# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libiscsi/libiscsi-9999.ebuild,v 1.1 2013/02/20 22:45:54 ryao Exp $

EAPI=4

AUTOTOOLS_AUTORECONF="1"

inherit git-2 autotools-utils

DESCRIPTION="iscsi client library and utilities"
HOMEPAGE="https://github.com/sahlberg/libiscsi"
SRC_URI=""
EGIT_REPO_URI="git://github.com/sahlberg/libiscsi.git"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
