# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/soulseek-qt/soulseek-qt-20130410.ebuild,v 1.1 2013/04/23 14:54:16 zx2c4 Exp $

EAPI=5

DESCRIPTION="Official binary Qt SoulSeek client."
HOMEPAGE="http://www.soulseekqt.net/"
LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BINARY_NAME="SoulseekQt-${PV:0:4}-$((${PV:4:2}))-$((${PV:6:2}))"
BASE_URI="http://www.soulseekqt.net/SoulseekQT/Linux/${BINARY_NAME}"
IUSE=""
SRC_URI="
	x86? ( ${BASE_URI}.tgz )
	amd64? ( ${BASE_URI}-64bit.tgz )
	"
DEPEND=""
RDEPEND="dev-qt/qtgui:4
	dev-qt/qtcore:4"
RESTRICT="mirror"
S="${WORKDIR}"

src_install() {
	exeinto /usr/bin
	use amd64 && BINARY_NAME="${BINARY_NAME}-64bit"
	newexe "${BINARY_NAME}" "${PN}"
}
