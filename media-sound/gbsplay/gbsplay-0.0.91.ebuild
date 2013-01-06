# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gbsplay/gbsplay-0.0.91.ebuild,v 1.3 2008/12/22 20:52:10 maekke Exp $

EAPI=1

inherit toolchain-funcs

DESCRIPTION="Nintendo Gameboy sound player for GBS format."
HOMEPAGE="http://gbsplay.berlios.de"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa nas nls oss"

RDEPEND="alsa? ( media-libs/alsa-lib )
	nas? ( media-libs/nas )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_compile() {
	tc-export AR CC

	./configure \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--docdir=/usr/share/doc/${PF} \
		--without-xmmsplugin \
		--without-test \
		$(use_enable nls i18n) \
		$(use_enable oss devdsp) \
		$(use_enable alsa) \
		$(use_enable nas) || die "./configure failed."

	emake CC="$(tc-getCC)" SPLINT="true" || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	prepalldocs
}
