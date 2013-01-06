# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellweather/gkrellweather-2.0.8.ebuild,v 1.1 2011/05/10 18:20:14 lack Exp $

EAPI=3
inherit gkrellm-plugin

IUSE=""
DESCRIPTION="GKrellM2 Plugin that monitors a METAR station and displays weather
info"
SRC_URI="http://sites.google.com/site/makovick/projects/${P}.tgz"
HOMEPAGE="http://sites.google.com/site/makovick/gkrellm-plugins"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

RDEPEND=">=dev-lang/perl-5.6.1
	>=net-misc/wget-1.5.3"
DEPEND=">=sys-apps/sed-4.0.5"

src_prepare() {
	epatch "${FILESDIR}/${P}-Respect-LDFLAGS.patch"
	epatch "${FILESDIR}/${P}-Move-GrabWeather.patch"
}

src_compile() {
	emake PREFIX=/usr || die
}

src_install () {
	gkrellm-plugin_src_install

	exeinto /usr/libexec/gkrellweather
	doexe GrabWeather
}
