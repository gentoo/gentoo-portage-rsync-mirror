# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aucdtect/aucdtect-0.8.2.ebuild,v 1.1 2012/10/29 14:17:43 yngwin Exp $

EAPI=5
inherit rpm versionator

MY_PV=$(replace_version_separator 2 '-')
MY_P="${PN}-${MY_PV}"
MY_PN="${PN/cd/CD}"

DESCRIPTION="Commandline FLAC CDDA authenticity verifier"
HOMEPAGE="http://en.true-audio.com"
SRC_URI="http://en.true-audio.com/ftp/${MY_P}.i586.rpm -> ${P}.rpm"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="amd64? ( app-emulation/emul-linux-x86-compat )"

S="${WORKDIR}/usr/local/bin"

src_install() {
	exeinto /usr/bin
	doexe "${MY_PN}"
}
