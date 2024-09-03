# ===========================================
# --coding:UTF-8 --
# file: test.py
# author: baobo
# date: 2024-09-03
# ===========================================

import os
import sys
import glob
import click
import time
import json
import pickle
from loguru import logger
from tqdm import tqdm


@logger.catch
@click.command()
@click.option('--root', default=None, type=str)
def main(root):
    logger.info(root)


if __name__ == '__main__':
    main()
