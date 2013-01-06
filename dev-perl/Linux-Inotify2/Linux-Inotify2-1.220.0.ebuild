# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Linux-Inotify2/Linux-Inotify2-1.220.0.ebuild,v 1.1 2011/07/17 08:36:49 tove Exp $

EAPI=4

MODULE_AUTHOR=MLEHMANN
MODULE_VERSION=1.22
inherit perl-module

DESCRIPTION="scalable directory/file change notification"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/common-sense"
RDEPEND="${DEPEND}"

SRC_TEST="do"
