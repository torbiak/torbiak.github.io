#!/usr/bin/env python3
import re
import pandas as pd
import numpy as np
import matplotlib
import matplotlib.pyplot as plt
from matplotlib.dates import date2num, DateFormatter, HourLocator

def shellhist():
    times = []
    cmds = []
    for line in open('shellhist'):
        fields  = line.split()
        if len(fields) < 3:
            continue
        _, time_str, cmd = fields[:3]
        if not re.search(r'^[a-zA-Z0-9_-]+$', cmd):
            continue
        times.append(time_str)
        cmds.append(cmd)
    return times, cmds

def binned(seconds):
    times, cmds = shellhist()
    df = pd.DataFrame({'cmd': cmds, 'freq': 1}, index=pd.DatetimeIndex(times))
    piv = df.pivot(columns='cmd', values='freq')
    binned = piv.resample('{}S'.format(seconds)).sum().fillna(0)
    return binned

def plot():
    fig, ax = plt.subplots()

    interval = 3600
    data = binned(interval)
    cmds = data.sum().sort_values(ascending=False)[:10].index.values
    total = data.sum(axis=1)
    float_times = data.index.to_series().map(lambda ts: date2num(ts.to_pydatetime()))

    plt.xticks(rotation='vertical')
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    ax.xaxis.set_major_formatter(DateFormatter("%b %d %H00"))
    ax.xaxis.set_major_locator(HourLocator(byhour=range(0, 24, 12)))
    ax.xaxis.set_minor_locator(HourLocator(byhour=range(0, 24, 3)))
    ax.set_title("Commands Run Per Hour")

    ax.plot(float_times, total,
        linestyle='-', linewidth=0.2, label='sum')

    bottom = np.zeros(len(float_times))
    bar_width = interval / 86400.0 # Fraction of a day.
    for cmd in cmds:
        vals = data[cmd].values
        ax.bar(float_times, vals,
            bottom=bottom, width=bar_width, label=cmd)
        bottom += vals

    ax.legend() # Called after all data has been plotted.

    plt.savefig('shellhist_pandas_stacked_bars.svg')

if __name__ == '__main__':
    plot()
