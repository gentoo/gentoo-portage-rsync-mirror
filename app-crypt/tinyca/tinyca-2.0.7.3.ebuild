# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/tinyca/tinyca-2.0.7.3.ebuild,v 1.1 2006/06/02 08:16:22 dragonheart Exp $

inherit eutils

MY_P="${PN}${PV/./-}"
DESCRIPTION="Simple Perl/Tk GUI to manage a small certification authority"
HOMEPAGE="http://tinyca.sm-zone.net/"
SRC_URI="http://tinyca.sm-zone.net/${MY_P}.tar.bz2"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-libs/openssl-0.9.7e
	dev-perl/Locale-gettext
	>=virtual/perl-MIME-Base64-2.12
	>=dev-perl/gtk2-perl-1.072"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-compositefix.patch"
	sed -i -e 's:./lib:/usr/share/tinyca/lib:g' \
		-e 's:./templates:/usr/share/tinyca/templates:g' \
		-e 's:./locale:/usr/share/locale:g' "${S}/tinyca2"
}

src_compile() {
	make -C po
}

locale_install() {
	dodir /usr/share/locale/$@/LC_MESSAGES/
	insinto /usr/share/locale/$@/LC_MESSAGES/
	doins locale/$@/LC_MESSAGES/tinyca2.mo
}

src_install() {
	exeinto /usr/bin
	newexe tinyca2 tinyca
	insinto /usr/share/tinyca/lib
	doins lib/*.pm
	insinto /usr/share/tinyca/lib/GUI
	doins lib/GUI/*.pm
	insinto /usr/share/tinyca/templates
	doins templates/*
	insinto /usr/share/
	strip-linguas de cs es
	use linguas_de && locale_install de
	use linguas_cs && locale_install cs
	use linguas_es && locale_install es
}
