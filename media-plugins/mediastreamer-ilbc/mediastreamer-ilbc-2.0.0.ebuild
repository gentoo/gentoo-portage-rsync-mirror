# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mediastreamer-ilbc/mediastreamer-ilbc-2.0.0.ebuild,v 1.7 2010/02/23 06:51:00 josejx Exp $

EAPI="2"

inherit multilib

MY_P="msilbc-${PV}"

DESCRIPTION="mediastreamer plugin: add iLBC support"
HOMEPAGE="http://www.linphone.org/"
SRC_URI="http://download.savannah.nongnu.org/releases/linphone/plugins/sources/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE="debug"

RDEPEND="dev-libs/ilbc-rfc3951
	>=media-libs/mediastreamer-2.0.0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i -e "s:\(\$prefix/\)lib:\1$(get_libdir):" configure \
		|| die "patching configure failed"
}

src_configure() {
	econf \
		--disable-strict \
		--disable-dependency-tracking \
		$(use_enable debug)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
