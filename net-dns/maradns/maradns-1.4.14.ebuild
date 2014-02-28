# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.4.14.ebuild,v 1.4 2014/02/28 09:54:31 pinkbyte Exp $

EAPI="5"

inherit eutils toolchain-funcs user

DESCRIPTION="A security-aware DNS server"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://maradns.samiam.org/download/${PV%.*}/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="authonly"

DEPEND="dev-lang/perl"
RDEPEND=""

pkg_setup() {
	ebegin "Creating group and users"
	enewgroup maradns 99
	enewuser duende 66 -1 -1 maradns
	enewuser maradns 99 -1 -1 maradns
	eend ${?}
}

src_prepare() {
	sed -i \
		-e "s:PREFIX/man:PREFIX/share/man:" \
		-e "s:PREFIX/doc/maradns-\$VERSION:PREFIX/share/doc/${PF}:" \
		build/install.locations || die
	sed -i \
		-e "s:-O2:\$(CFLAGS) \$(LDFLAGS):" \
		-e "s:\$(CC):$(tc-getCC):g" \
		-e "s:make:\$(MAKE):g" \
		build/Makefile.linux || die
	if use authonly ; then
		sed -e "/provide dns/d" \
			"${FILESDIR}/maradns.rc6" > "${T}/maradns.rc6" || die
	else
		cp "${FILESDIR}/maradns.rc6" "${T}/maradns.rc6" || die
	fi
	epatch_user
}

src_configure() {
	./configure $(use authonly && echo '--authonly') || die "Failed to configure ${PN}"
}

src_install() {
	if use authonly ; then
		newsbin server/maradns.authonly maradns
	else
		dosbin server/maradns
	fi

	dosbin tcp/zoneserver

	dobin tcp/getzone tcp/fetchzone tools/askmara tools/duende

	doman doc/en/man/*.[1-9]

	dodoc maradns.gpg.key
	dodoc doc/en/{QuickStart,README,*.txt}
	dohtml doc/en/*.html
	dohtml -r doc/en/webpage

	docinto examples
	dodoc doc/en/examples/example_*

	insinto /etc
	newins doc/en/examples/example_mararc mararc
	insinto /etc/maradns
	newins doc/en/examples/example_csv2 db.example.net

	keepdir /etc/maradns/logger

	newinitd "${T}"/maradns.rc6 maradns
	newinitd "${FILESDIR}"/zoneserver.rc6 zoneserver
}
