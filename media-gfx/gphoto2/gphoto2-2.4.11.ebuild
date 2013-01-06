# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gphoto2/gphoto2-2.4.11.ebuild,v 1.8 2012/05/05 07:00:27 jdhore Exp $

EAPI="4"

inherit eutils autotools

DESCRIPTION="free, redistributable digital camera software application"
HOMEPAGE="http://www.gphoto.org/"
SRC_URI="mirror://sourceforge/gphoto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE="aalib exif ncurses nls readline"

# aalib -> needs libjpeg
# raise libgphoto to get a proper .pc
RDEPEND="virtual/libusb:0
	dev-libs/popt
	>=media-libs/libgphoto2-2.4.11[exif?]
	ncurses? ( dev-libs/cdk )
	aalib? (
		media-libs/aalib
		virtual/jpeg:0 )
	exif? (	media-libs/libexif )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	nls? ( >=sys-devel/gettext-0.14 )"

src_prepare() {
	epatch "${FILESDIR}/${P}-cdk-libs.patch"
	eautoreconf
}

src_configure() {
	CPPFLAGS="-I/usr/include/cdk" econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_with aalib) \
		$(use_with aalib jpeg) \
		$(use_with exif libexif auto) \
		$(use_with ncurses cdk) \
		$(use_enable nls) \
		$(use_with readline)
}

src_install() {
	emake DESTDIR="${D}" \
		HTML_DIR="${D}"/usr/share/doc/${PF}/sgml \
		install

	dodoc ChangeLog NEWS* README AUTHORS || die "dodoc failed"
	rm -rf "${D}"/usr/share/doc/${PF}/sgml/gphoto2
}
