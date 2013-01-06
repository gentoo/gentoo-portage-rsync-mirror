# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/maradns/maradns-1.4.11.ebuild,v 1.2 2012/06/14 02:13:48 zmedico Exp $

EAPI="4"
inherit toolchain-funcs user

DESCRIPTION="A security-aware DNS server"
HOMEPAGE="http://www.maradns.org/"
SRC_URI="http://www.maradns.org/download/${PV%.*}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="authonly"

DEPEND="dev-lang/perl"
RDEPEND=""

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
}

src_configure() {
	local myconf
	if use authonly ; then
		myconf="${myconf} --authonly"
	fi
	./configure ${myconf} # || die
}

src_install() {
	if use authonly ; then
		newsbin server/maradns.authonly maradns || die
	else
		dosbin server/maradns || die
	fi

	dosbin tcp/zoneserver || die

	dobin tcp/getzone tcp/fetchzone tools/askmara tools/duende || die

	doman doc/en/man/*.[1-9] || die

	dodoc maradns.gpg.key || die
	dodoc doc/en/{QuickStart,README,*.txt} || die
	dohtml doc/en/*.html || die
	dohtml -r doc/en/webpage || die
	docinto examples; dodoc doc/en/examples/example_* || die

	insinto /etc; newins doc/en/examples/example_mararc mararc || die
	insinto /etc/maradns; newins doc/en/examples/example_csv2 db.example.net || die
	keepdir /etc/maradns/logger || die

	newinitd "${T}"/maradns.rc6 maradns || die
	newinitd "${FILESDIR}"/zoneserver.rc6 zoneserver || die
}

pkg_postinst() {
	enewgroup maradns 99
	enewuser duende 66 -1 -1 maradns
	enewuser maradns 99 -1 -1 maradns
}
