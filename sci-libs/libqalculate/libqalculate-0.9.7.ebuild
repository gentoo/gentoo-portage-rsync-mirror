# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/libqalculate/libqalculate-0.9.7.ebuild,v 1.12 2012/05/04 08:22:53 jdhore Exp $

EAPI=4

DESCRIPTION="A modern multi-purpose calculator library"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE="readline static-libs"

COMMON_DEPEND=">=sci-libs/cln-1.2
	dev-libs/libxml2:2
	dev-libs/glib:2
	sys-libs/zlib
	readline? ( sys-libs/readline )"
DEPEND="${COMMON_DEPEND}
	virtual/pkgconfig
	dev-util/intltool
	sys-devel/gettext"
RDEPEND="${COMMON_DEPEND}
	>=sci-visualization/gnuplot-3.7
	net-misc/wget"

src_prepare() {
	cat >po/POTFILES.skip <<-EOF
	# Required by make check
	data/currencies.xml.in
	data/datasets.xml.in
	data/elements.xml.in
	data/functions.xml.in
	data/planets.xml.in
	data/units.xml.in
	data/variables.xml.in
	src/defs2doc.cc
	EOF
}

src_configure() {
	econf \
		$(use_enable static-libs static) \
		$(use_with readline)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README* TODO
	rm -f "${ED}"usr/lib*/${PN}.la
}
