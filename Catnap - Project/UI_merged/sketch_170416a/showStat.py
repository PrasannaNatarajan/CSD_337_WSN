#-------------------------------------------------------------------------------
# Name:        module1
# Purpose:
#
# Author:      prasanna
#
# Created:     16-04-2017
# Copyright:   (c) prasanna 2017
# Licence:     <your licence>
#-------------------------------------------------------------------------------

import pandas as pd
import matplotlib.pyplot as plt
data = pd.read_csv("C:\\Users\\Atish Majumdar\\Desktop\\UI_merged\\sketch_170416a\\data.csv");
data.plot()
plt.show()
