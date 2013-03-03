# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/klayout/klayout-0.20.2.ebuild,v 1.4 2013/03/02 23:19:22 hwoarang Exp $

EAPI="2"

USE_RUBY="ruby18"
# note: define maximally ONE implementation here

RUBY_OPTIONAL=yes

inherit eutils multilib toolchain-funcs ruby-ng

DESCRIPTION="Viewer and editor for GDS and OASIS integrated circuit layouts"
HOMEPAGE="http://www.klayout.de/"
SRC_URI="http://www.klayout.de/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ruby"

RDEPEND="dev-qt/qtgui:4[qt3support]"
DEPEND="${RDEPEND}"

all_ruby_prepare() {
	epatch "${FILESDIR}/${P}-configureonly.patch"

	# now we generate the stub build configuration file for the home-brew build system
	cp "${FILESDIR}/${P}-Makefile.conf.linux-gentoo" "${S}/config/Makefile.conf.linux-gentoo" || die
}

each_ruby_configure() {
	local rbflags

	if use ruby ; then
		rbflags="-rblib $(ruby_get_libruby) -rbinc $(ruby_get_hdrdir)"
	fi

	./build.sh \
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
	emake all || die "Build failed"
}

each_ruby_install() {
	cd build.linux-gentoo
	emake install || die "make install failed"

	cd ..
	dobin \
		bin/klayout \
		bin/strm2gds \
		bin/strm2oas \
		bin/strmclip \
		bin/strmcmp || die "Installation of binaries failed"

	insinto /usr/share/${PN}/testdata/gds
	doins testdata/gds/*.gds || die "Installation of gds testdata failed"
	insinto /usr/share/${PN}/testdata/oasis
	doins testdata/oasis/*.oas testdata/oasis/*.ot || die "Installation of oasis testdata failed"

	if use ruby; then
		insinto /usr/share/${PN}
		doins -r testdata/ruby || die "Installation of ruby testdata failed"
	fi
}
