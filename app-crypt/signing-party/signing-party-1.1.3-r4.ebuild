# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/signing-party/signing-party-1.1.3-r4.ebuild,v 1.6 2011/05/24 09:47:21 hwoarang Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="A collection of several tools related to OpenPGP"
HOMEPAGE="http://pgp-tools.alioth.debian.org/"
SRC_URI="mirror://debian/pool/main/s/signing-party/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~ppc-macos"
IUSE=""

DEPEND=""
RDEPEND=">=app-crypt/gnupg-1.3.92
	dev-perl/GnuPG-Interface
	dev-perl/text-template
	dev-perl/MIME-tools
	net-mail/qprint
	>=dev-perl/MailTools-1.62
	virtual/mailx
	virtual/mta
	dev-lang/perl
	|| (
		dev-perl/libintl-perl
		dev-perl/Text-Iconv
		app-text/recode
	)"

src_prepare() {
	# app-crypt/keylookup
	rm -fr keylookup
	# media-gfx/springgraph
	rm -fr springgraph

	epatch "${FILESDIR}"/${PN}-makefile.diff

	sed -i -e \
	"s:/usr/share/doc/signing-party/caff/caffrc.sample:${EPREFIX}/usr/share/doc/${P}/caff/caffrc.sample.gz:g" \
	caff/caff || die "Sed failed"
	sed -i -e "s/make pgpring/\$(MAKE) pgpring/" keyanalyze/Makefile \
	|| die "Sed failed"
	sed -i -e \
		"s|:/usr/share/signing-party|:${EPREFIX}/usr/share/signing-party|" \
		gpgsigs/gpgsigs || die "Sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	# Check Makefile when a new tool is introduced to this package.
	# caff
	dobin caff/caff caff/pgp-clean caff/pgp-fixkey || die
	docinto caff
	dodoc caff/{README*,THANKS,TODO,caffrc.sample} || die
	# gpgdir
	dobin gpgdir/gpgdir || die
	docinto gpgdir
	dodoc gpgdir/{VERSION,LICENSE,README,INSTALL,CREDITS,ChangeLog*} || die
	# gpg-key2ps
	dobin gpg-key2ps/gpg-key2ps || die
	docinto gpg-key2ps
	dodoc gpg-key2ps/README || die
	# gpglist
	dobin gpglist/gpglist || die
	# gpg-mailkeys
	dobin gpg-mailkeys/gpg-mailkeys || die
	docinto gpg-mailkeys
	dodoc gpg-mailkeys/{example.gpg-mailkeysrc,README} || die
	# gpgparticipants
	dobin gpgparticipants/gpgparticipants || die
	# gpgwrap
	dobin gpgwrap/bin/gpgwrap || die
	docinto gpgwrap
	dodoc gpgwrap/{LICENSE,NEWS,README} || die
	doman gpgwrap/doc/gpgwrap.1 || die
	# gpgsigs
	dobin gpgsigs/gpgsigs || die
	insinto /usr/share/signing-party
	doins gpgsigs/gpgsigs-eps-helper || die
	# keyanalyze
	# TODO: some of the scripts are intended for webpages, and not really
	# packaging, so they are NOT installed yet.
	newbin keyanalyze/pgpring/pgpring pgpring-keyanalyze || die
	dobin keyanalyze/{keyanalyze,process_keys} || die
	docinto keyanalyze
	dodoc keyanalyze/{README,Changelog} || die
	# See app-crypt/keylookup instead
	#dobin keylookup/keylookup
	#docinto keylookup
	#dodoc keylookup/NEWS
	# sig2dot
	dobin sig2dot/sig2dot || die
	dodoc sig2dot/README.sig2dot || die
	# See media-gfx/springgraph instead
	#dobin springgraph/springgraph
	#dodoc springgraph/README.springgraph
	# all other manpages, and the root doc
	doman */*.1 || die
	dodoc README || die
}
