# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ldns-utils/ldns-utils-1.6.16.ebuild,v 1.1 2013/01/22 02:42:49 robbat2 Exp $

EAPI="3"
inherit autotools eutils

MY_P="${P/-utils}"
DESCRIPTION="Set of utilities to simplify various dns(sec) tasks."
HOMEPAGE="http://www.nlnetlabs.nl/projects/ldns/"
SRC_URI="http://www.nlnetlabs.nl/downloads/ldns/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~x86"
IUSE="ecdsa examples gost ssl"

DEPEND=">=net-libs/ldns-${PV}[ecdsa?,gost?,ssl?]
	examples? ( net-libs/libpcap )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_configure() {
	cd "${S}"/drill
	econf $(use_with ssl) || die

	if use examples; then
		cd "${S}"/examples
		econf \
			$(use_enable ecdsa) \
			$(use_enable gost) \
			$(use_enable ssl sha2) \
			$(use_with ssl) || die
	fi
}

src_compile() {
	emake -C drill || die "emake for drill failed"
	if use examples; then
		emake -C examples || die "emake for examples failed"
	fi
}

src_install() {
	cd "${S}"/drill
	emake DESTDIR="${D}" install || die "emake install for drill failed"
	dodoc ChangeLog.22-nov-2005 README REGRESSIONS || die

	if use examples; then
		cd "${S}"/examples
		emake DESTDIR="${D}" install || die "emake install for examples failed"
		newdoc README README.examples || die
	fi
}
