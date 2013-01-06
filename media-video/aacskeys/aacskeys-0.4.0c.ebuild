# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/aacskeys/aacskeys-0.4.0c.ebuild,v 1.3 2011/09/13 00:35:35 beandog Exp $

EAPI=2
inherit eutils

DESCRIPTION="Decrypt keys from an AACS source (HD DVD / Blu-Ray)"
HOMEPAGE="http://forum.doom9.org/showthread.php?t=123311"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/openssl[-bindist]"
DEPEND="dev-java/sun-jdk:1.6
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}/${P}-aacskeys-makefile.patch"
	epatch "${FILESDIR}/${P}-libaacskeys-makefile.patch"
}

src_install() {
	dobin bin/linux/aacskeys || die
	dolib lib/linux/libaacskeys.so || die
	dodoc HostKeyCertificate.txt ProcessingDeviceKeysSimple.txt \
		README.txt || die
}
