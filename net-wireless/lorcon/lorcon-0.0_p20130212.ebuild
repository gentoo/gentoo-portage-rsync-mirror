# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/lorcon/lorcon-0.0_p20130212.ebuild,v 1.2 2013/05/28 05:05:22 zerochaos Exp $

EAPI=5

PYTHON_DEPEND="python? 2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

USE_RUBY="ruby18 ruby19"
RUBY_OPTIONAL=yes

inherit distutils ruby-ng

DESCRIPTION="A generic library for injecting 802.11 frames"
HOMEPAGE="http://802.11ninja.net/lorcon"

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://code.google.com/p/lorcon/"
	inherit git-2
	KEYWORDS=""
else
	SRC_URI="http://dev.gentoo.org/~zerochaos/distfiles/${P}.tar.xz"
	KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="python ruby"

DEPEND="ruby? ( $(ruby_implementations_depend) )
	dev-libs/libnl
	net-libs/libpcap"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${P}

pkg_setup() {
	if use python; then
		python_pkg_setup;
		DISTUTILS_SETUP_FILES=("${S}/pylorcon2|setup.py")
	fi
	use ruby && ruby-ng_pkg_setup
}

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
		cp -R "${S}/" "${WORKDIR}/all"
	fi
	default_src_unpack
	#ruby-ng_src_unpack doesn't seem to like mixing with git so we just copy things above
	use ruby && ruby-ng_src_unpack
}

src_prepare() {
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' pylorcon2/PyLorcon2.c
	sed -i 's#find_library("orcon2", "lorcon_list_drivers", "lorcon2/lorcon.h") and ##' ruby-lorcon/extconf.rb
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' ruby-lorcon/Lorcon2.h
	use python && distutils_src_prepare
	use ruby && ruby-ng_src_prepare
}

src_configure() {
	default_src_configure
}

src_compile() {
	default_src_compile
	use ruby && ruby-ng_src_compile
	if use python; then
		LDFLAGS+=" -L${S}/.libs/"
		distutils_src_compile
	fi
}

src_install() {
	emake DESTDIR="${ED}" install
	use python && distutils_src_install
	use ruby && ruby-ng_src_install
}

src_test() {
	:
}

pkg_postinst() {
	use python && distutils_pkg_postinst
}
pkg_postrm() {
	use python && distutils_pkg_postrm
}

each_ruby_compile() {
	sed -i "s#-I/usr/include/lorcon2#-I${WORKDIR}/${P}/ruby-lorcon -L${WORKDIR}/${P}/.libs#" ruby-lorcon/extconf.rb
	"${RUBY}" -C ruby-lorcon extconf.rb || die
	sed -i 's#<lorcon2/lorcon.h>#"../lorcon.h"#' ruby-lorcon/Lorcon2.h
	sed -i "s#-L\.#-L. -L${WORKDIR}/${P}/.libs -lorcon2 #g" ruby-lorcon/Makefile || die
	emake -C ruby-lorcon
}

each_ruby_install() {
	DESTDIR="${ED}" emake -C ruby-lorcon install
}
