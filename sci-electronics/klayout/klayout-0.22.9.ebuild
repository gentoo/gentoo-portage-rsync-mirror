# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/klayout/klayout-0.22.9.ebuild,v 1.3 2013/12/07 13:18:27 johu Exp $

EAPI=5

USE_RUBY="ruby19"
# note: define maximally ONE implementation here

RUBY_OPTIONAL=no
inherit eutils multilib toolchain-funcs ruby-ng

DESCRIPTION="Viewer and editor for GDS and OASIS integrated circuit layouts"
HOMEPAGE="http://www.klayout.de/"
SRC_URI="http://178.77.72.242/downloads/${P}.tar.gz"

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

	epatch "${FILESDIR}/${PN}-0.22.8-noautoruby.patch"
}

each_ruby_configure() {
	export RUBY
	./build.sh \
		-dry-run \
		-platform linux-gentoo \
		-bin bin \
		-qtbin /usr/bin \
		-qtinc /usr/include/qt4 \
		-qtlib /usr/$(get_libdir)/qt4 || die "Configuration failed"
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
