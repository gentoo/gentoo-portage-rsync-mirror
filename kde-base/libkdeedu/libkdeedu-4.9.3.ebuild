# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.9.3.ebuild,v 1.4 2012/11/30 16:33:34 ago Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.6.1. Tests are fundamentally broken,
# see bug 258857 for details.
RESTRICT=test

add_blocker kvtml-data
