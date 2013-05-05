# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcron/kcron-4.10.2.ebuild,v 1.5 2013/05/05 10:13:55 ago Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdeadmin"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE Task Scheduler"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="!prefix? ( virtual/cron )"
