# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/diff/diff-2.1.4.ebuild,v 1.7 2007/11/16 15:08:27 drac Exp $

ROX_CLIB_VER=2.1.8
inherit rox

MY_PN="Diff"
DESCRIPTION="This diff program for ROX that provides DND functionality.  By Stephen Watson"
HOMEPAGE="http://www.kerofin.demon.co.uk/rox/diff.html"
SRC_URI="http://www.kerofin.demon.co.uk/rox/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 x86"

APPNAME=${MY_PN}
S=${WORKDIR}
