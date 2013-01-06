# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/mgetty/mgetty-1.1.36-r3.ebuild,v 1.8 2012/06/14 01:46:13 zmedico Exp $

EAPI=1
inherit toolchain-funcs flag-o-matic eutils user

DESCRIPTION="fax and voice modem programs"
SRC_URI="ftp://mgetty.greenie.net/pub/mgetty/source/1.1/${PN}${PV}-Jun15.tar.gz"
HOMEPAGE="http://mgetty.greenie.net/"

DEPEND="doc? ( virtual/latex-base virtual/texi2dvi )
	>=sys-apps/sed-4
	sys-apps/gawk
	sys-apps/groff
	dev-lang/perl
	sys-apps/texinfo
	fax? ( !net-misc/hylafax )"
RDEPEND="${DEPEND}
	fax? ( media-libs/netpbm app-text/ghostscript-gpl )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc x86"
IUSE="doc +fax fidonet"

pkg_setup() {
	enewgroup fax
	enewuser fax -1 -1 /dev/null fax
}

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
	epatch "${FILESDIR}/${P}-qa-fixes.patch"
	epatch "${FILESDIR}/${P}-callback.patch" # add callback install to Makefile
	epatch "${FILESDIR}/Lucent.c.patch" # Lucent modem CallerID patch - bug #80366
	use fax || epatch "${FILESDIR}/${P}-nofax.patch" # don't install fax related files - bug #195467
	epatch "${FILESDIR}/${P}-tmpfile.patch" # fix security bug 235806

	sed -e 's:var/log/mgetty:var/log/mgetty/mgetty:' \
		-e 's:var/log/sendfax:var/log/mgetty/sendfax:' \
		-e 's:\/\* \(\#define CNDFILE "dialin.config"\) \*\/:\1:' \
		-e 's:\(\#define FAX_NOTIFY_PROGRAM\).*:\1 "/etc/mgetty+sendfax/new_fax":' \
		"${S}/policy.h-dist" > "${S}/policy.h"

	sed -i -e 's:/usr/local/lib/mgetty+sendfax:/etc/mgetty+sendfax:' faxrunq.config
	sed -i -e 's:/usr/local/bin/g3cat:/usr/bin/g3cat:' faxrunq.config fax/faxspool.rules

	sed -e "/^doc-all:/s/mgetty.asc mgetty.info mgetty.dvi mgetty.ps/mgetty.info/" \
		-i "${S}/doc/Makefile"
	if use doc; then
		sed -e "s/^doc-all:/doc-all: mgetty.ps/" \
			-i "${S}/doc/Makefile"
	fi
}

src_compile() {
	use fidonet && append-flags "-DFIDO"
	append-flags "-DAUTO_PPP"

	# bug #299421
	VARTEXFONTS="${T}"/fonts emake -j1 prefix=/usr \
		CC="$(tc-getCC)" \
		CONFDIR=/etc/mgetty+sendfax \
		CFLAGS="${CFLAGS}" \
		LDFLAGS="${LDFLAGS}" \
		all vgetty || die "make failed."
}

src_install () {
	# parallelization issue: vgetty-install target fails if install target
	#                        isn't finished
	local targets
	for targets in install "vgetty-install install-callback"; do
		emake prefix="${D}/usr" \
			INFODIR="${D}/usr/share/info" \
			CONFDIR="${D}/etc/mgetty+sendfax" \
			MAN1DIR="${D}/usr/share/man/man1" \
			MAN4DIR="${D}/usr/share/man/man4" \
			MAN5DIR="${D}/usr/share/man/man5" \
			MAN8DIR="${D}/usr/share/man/man8" \
			SBINDIR="${D}/usr/sbin" \
			BINDIR="${D}/usr/bin" \
			VOICE_DIR="${D}/var/spool/voice" \
			PHONE_GROUP=fax \
			PHONE_PERMS=755 \
			spool="${D}/var/spool" \
			${targets} || die "emake $targets failed."
	done

	keepdir /var/log/mgetty

	#Install mgetty into /sbin (#119078)
	dodir /sbin && \
		mv "${D}"/usr/sbin/mgetty "${D}"/sbin && \
		dosym /sbin/mgetty /usr/sbin/mgetty || die "failed to install /sbin/mgetty"
	#Don't install ct (#106337)
	rm "${D}"/usr/bin/ct || die "failed to remove useless ct program"

	dodoc BUGS ChangeLog README.1st Recommend THANKS TODO \
		doc/*.txt doc/modems.db || die "dodoc failed."
	doinfo doc/mgetty.info || die "doinfo failed."

	docinto vgetty
	dodoc voice/{Readme,Announce,ChangeLog,Credits} || die "vgetty voice failed."

	if use doc; then
		dodoc doc/mgetty.ps || die "mgetty.ps failed"
	fi

	docinto vgetty/doc
	dodoc voice/doc/*

	if use fax; then
		mv samples/new_fax.all samples_new_fax.all || die "move failed."
		docinto samples
		dodoc samples/*

		docinto samples/new_fax
		dodoc samples_new_fax.all/*
	fi

	if ! use fax; then
		insinto /usr/share/${PN}/frontends
		doins -r frontends/{voice,network}
	else
		insinto /usr/share/${PN}
		doins -r frontends
	fi
	insinto /usr/share/${PN}
	doins -r patches
	insinto /usr/share/${PN}/voice
	doins -r voice/{contrib,Perl,scripts}

	diropts -m 0750 -o fax -g fax
	dodir /var/spool/voice
	keepdir /var/spool/voice/incoming
	keepdir /var/spool/voice/messages
	if use fax; then
		dodir /var/spool/fax
		dodir /var/spool/fax/outgoing
		keepdir /var/spool/fax/outgoing/locks
		keepdir /var/spool/fax/incoming
	fi
}

pkg_postinst() {
	elog "Users who wish to use the fax or voicemail capabilities must be members"
	elog "of the group fax in order to access files"
	elog
	elog "If you want to grab voice messages from a remote location, you must save"
	elog "the password in /var/spool/voice/.code file"
	echo
	ewarn "/var/spool/voice/.code and /var/spool/voice/messages/Index"
	ewarn "are not longer created by this automatically!"
}
