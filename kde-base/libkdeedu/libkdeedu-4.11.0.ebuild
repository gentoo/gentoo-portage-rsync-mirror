# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/libkdeedu/libkdeedu-4.11.0.ebuild,v 1.1 2013/08/14 20:23:39 dilfridge Exp $

EAPI=5

inherit kde4-base

DESCRIPTION="Common library for KDE educational apps"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

# 4 of 4 tests fail. Last checked for 4.6.1. Tests are fundamentally broken,
# see bug 258857 for details.
RESTRICT=test
