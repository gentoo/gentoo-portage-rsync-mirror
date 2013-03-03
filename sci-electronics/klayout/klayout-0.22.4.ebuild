# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/klayout/klayout-0.22.4.ebuild,v 1.4 2013/03/02 23:19:22 hwoarang Exp $

EAPI=5

USE_RUBY="ruby18"
# note: define maximally ONE implementation here

RUBY_OPTIONAL=no
inherit eutils multilib toolchain-funcs ruby-ng

DESCRIPTION="Viewer and editor for GDS and OASIS integrated circuit layouts"
HOMEPAGE="http://www.klayout.de/"
SRC_URI="http://www.klayout.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	dev-qt/qtgui:4[qt3support]
	$(ruby_implementations_depend)
"
DEPEND="${RDEPEND}"

all_ruby_prepare() {
	# now we generate the stub build configuration file for the home-brew build system
	cp "${FILESDIR}/${PN}-0.21.7-Makefile.conf.linux-gentoo" "${S}/config/Makefile.conf.linux-gentoo" || die
}

each_ruby_configure() {
	local rbflags
	rbflags="-rblib $(ruby_get_libruby) -rbinc $(ruby_get_hdrdir)"

	./build.sh \
		-dry-run \
		-platform linux-gentoo \
		-bin bin \
		-qtbin /usr/bin \
		-qtinc /usr/include/qt4 \
		-qtlib /usr/$(get_libdir)/qt4 \
		${rbflags} || die "Configuration failed"
}

each_ruby_compile() {
	cd build.linux-gentoo
	tc-export CC CXX AR LD RANLIB
	export AR="${AR} -r"
	emake all
}

each_ruby_install() {
	cd build.linux-gentoo
	emake install

	cd ..
	dobin bin/klayout

	insinto /usr/share/${PN}/testdata/gds
	doins testdata/gds/*.gds
	insinto /usr/share/${PN}/testdata/oasis
	doins testdata/oasis/*.oas testdata/oasis/*.ot

	insinto /usr/share/${PN}
	doins -r testdata/ruby
}
