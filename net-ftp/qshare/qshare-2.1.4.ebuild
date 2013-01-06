# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/qshare/qshare-2.1.4.ebuild,v 1.3 2012/11/20 20:09:18 ago Exp $

EAPI=4

inherit eutils cmake-utils

DESCRIPTION="FTP server with a service discovery feature"
HOMEPAGE="http://www.zuzuf.net/qshare/"
SRC_URI="http://www.zuzuf.net/qshare/files/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="net-dns/avahi[mdnsresponder-compat]
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS README )
