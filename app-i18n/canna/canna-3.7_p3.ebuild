# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canna/canna-3.7_p3.ebuild,v 1.10 2012/07/12 08:46:22 naota Exp $

inherit cannadic eutils multilib

MY_P="Canna${PV//./}"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://canna.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/canna/9565/${MY_P/_/}.tar.bz2"

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

DEPEND=">=sys-apps/sed-4
	x11-misc/gccmakedep
	x11-misc/imake
	doc? ( >=dev-texlive/texlive-langcjk-2010 )"
RDEPEND=""

S="${WORKDIR}/${MY_P/_/}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	find . -name '*.man' -o -name '*.jmn' | xargs sed -i.bak -e 's/1M/8/g'
	sed -e "s%@cannapkgver@%${PF}%" \
		"${FILESDIR}"/${P/_*/}-gentoo.diff.in > "${T}/${PF}-gentoo.diff"
	epatch "${T}"/${PF}-gentoo.diff
	cd dic/phono
	epatch "${FILESDIR}"/${PN}-kpdef-gentoo.diff

	cd "${S}"
	# Multilib-strict fix for amd64
	sed -i -e "s:\(DefLibCannaDir.*\)/lib:\1/$(get_libdir):g" Canna.conf*
	# fix deprecated sort syntax
	sed -e 's:^\(sortcmd=\".* -s\).*$:\1 -k 1,1\":' \
		-i cmd/mkbindic/mkbindic.cpp
}

src_compile() {
	xmkmf || die

	#make libCannaDir=../lib/canna canna || die
	# bug #279706
	emake -j1 canna || die

	if use doc ; then
		einfo "Compiling DVI, PS (and PDF) document"
		cd doc/man/guide/tex
		xmkmf || die
		make JLATEXCMD=platex \
			DVI2PSCMD="dvips -f" \
			canna.dvi canna.ps || die
		if has_version 'app-text/dvipdfmx' && \
			( has_version 'app-text/acroread' \
			|| has_version 'app-text/xpdf-japanese' ); then
			make JLATEXCMD=platex \
				DVI2PSCMD="dvips -f" \
				canna.pdf || die
		fi
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	make DESTDIR="${D}" install.man || die

	# install default.canna (removed from Canna36p4)
	insinto /usr/share/canna
	newins misc/initfiles/verbose.canna default.canna

	# cannakill should link to /usr/bin/catdic
	dosym ../bin/catdic /usr/sbin/cannakill

	dodir /usr/share/man/man8 /usr/share/man/ja/man8
	for man in cannaserver cannakill ; do
		for mandir in "${D}"/usr/share/man "${D}"/usr/share/man/ja ; do
			mv ${mandir}/man1/${man}.1 ${mandir}/man8/${man}.8
		done
	done

	dodoc CHANGES.jp ChangeLog INSTALL* README* WHATIS*

	if use doc ; then
		insinto /usr/share/doc/${PF}
		doins doc/man/guide/tex/canna.{dvi,ps,pdf}
	fi

	newinitd "${FILESDIR}"/canna.initd canna || die
	newconfd "${FILESDIR}"/canna.confd canna || die
	insinto /etc/		; newins "${FILESDIR}"/canna.hosts hosts.canna || die
	keepdir /var/log/canna/ || die

	# for backward compatibility
	dosbin "${FILESDIR}"/update-canna-dics_dir

	insinto /var/lib/canna/dic/dics.d/
	newins "${D}"/var/lib/canna/dic/canna/dics.dir 00canna.dics.dir

	# fix permission for user dictionary
	keepdir /var/lib/canna/dic/{user,group}
	fowners root:bin /var/lib/canna/dic/{user,group}
	fperms 775 /var/lib/canna/dic/{user,group}
}

pkg_postinst() {
	update-cannadic-dir
	elog
	elog "Canna dictionary format has been changed."
	elog "You should rebuild app-dict/canna-* after emerge."
	elog
}

pkg_prerm() {
	if [ -S /tmp/.iroha_unix/IROHA ] ; then
		# make sure cannaserver get stopped because otherwise
		# we cannot stop it with /etc/init.d after emerge -C canna
		einfo
		einfo "Stopping Canna for safe unmerge"
		einfo
		/etc/init.d/canna stop
		touch "${T}"/canna.cookie
	fi
}

pkg_postrm() {
	if [ -f /usr/sbin/cannaserver -a -e "${T}"/canna.cookie ] ; then
		#update-cannadic-dir
		einfo
		einfo "Restarting Canna"
		einfo
		/etc/init.d/canna start
		rm -f "${T}"/canna.cookie
	fi
}
