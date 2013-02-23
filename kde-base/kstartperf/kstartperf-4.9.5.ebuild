# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstartperf/kstartperf-4.9.5.ebuild,v 1.5 2013/02/23 16:58:31 ago Exp $

EAPI=4

KMNAME="kdesdk"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="Measures starting performance of applications"
KEYWORDS="amd64 ~arm ppc ~ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"
