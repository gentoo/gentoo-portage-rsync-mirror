# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/caps-plugins/caps-plugins-0.4.4.ebuild,v 1.5 2012/11/26 23:58:09 aballier Exp $

inherit eutils toolchain-funcs multilib

IUSE=""
MY_P=caps-${PV}

DESCRIPTION="The CAPS Audio Plugin Suite - LADSPA plugin suite"
HOMEPAGE="http://quitte.de/dsp/caps.html"
SRC_URI="http://quitte.de/dsp/caps_${PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="media-libs/ladspa-sdk"

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CFLAGS="${CXXFLAGS} -fPIC -DPIC" _LDFLAGS="-nostartfiles -shared ${LDFLAGS}" CC="$(tc-getCXX)" || die
}

src_install() {
	dodoc README CHANGES || die
	dohtml caps.html || die
	insinto /usr/$(get_libdir)/ladspa
	insopts -m0755
	doins *.so || die
	insinto /usr/share/ladspa/rdf
	insopts -m0644
	doins *.rdf || die
}
