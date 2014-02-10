# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bdf2psf/bdf2psf-1.104.ebuild,v 1.1 2014/02/10 06:31:24 floppym Exp $

EAPI=5

DESCRIPTION="Converter to generate console fonts from BDF source fonts"
HOMEPAGE="http://packages.debian.org/sid/bdf2psf"
SRC_URI="mirror://debian/pool/main/c/console-setup/console-setup_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

S="${WORKDIR}/console-setup-${PV}"

src_compile() {
	:
}

src_install() {
	dobin Fonts/bdf2psf

	insinto usr/share/bdf2psf
	doins -r Fonts/*.equivalents Fonts/*.set Fonts/fontsets

	doman man/bdf2psf.1
	dodoc debian/README.fontsets
}
