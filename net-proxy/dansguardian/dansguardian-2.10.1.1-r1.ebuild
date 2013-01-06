# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/dansguardian/dansguardian-2.10.1.1-r1.ebuild,v 1.2 2012/05/03 04:35:53 jdhore Exp $

EAPI="2"

inherit eutils

DESCRIPTION="Web content filtering via proxy"
HOMEPAGE="http://dansguardian.org"
SRC_URI="http://dansguardian.org/downloads/2/Stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="clamav kaspersky debug ntlm pcre"

RDEPEND="sys-libs/zlib
	pcre? ( dev-libs/libpcre )
	clamav? ( >=app-antivirus/clamav-0.93 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

pkg_setup() {
	if has_version "<${CATEGORY}/${PN}-2.9" ; then
		ewarn "This version introduces brand new USE flags:"
		ewarn "   clamav kaspersky ntlm pcre"
		echo

		local f="${ROOT}/etc/dansguardian"
		f=${f//\/\///}
		if [ -d "${f}" ] ; then
			eerror "The structure of ${f} has changed in this version!"
			eerror "For avoiding confusion, you must either move or delete the old ${f},"
			eerror "then continue with the upgrade:"
			eerror "   mv '${f}' '${f}.old'"
			eerror "   emerge --resume"
			die "Obsolete config files detected"
		fi
	fi

	if ! use clamav; then
		enewgroup dansguardian
		enewuser dansguardian -1 -1 /dev/null dansguardian
	fi
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44.patch
}

src_configure() {
	local myconf="--with-logdir=/var/log/dansguardian
		--with-piddir=/var/run
		--docdir=/usr/share/doc/${PF}
		--htmldir=/usr/share/doc/${PF}/html
		$(use_enable pcre)
		$(use_enable ntlm)
		--enable-orig-ip
		--enable-fancydm
		--enable-email"
	if use clamav; then
		# readd --enable-clamav in the next version if it works with >=clamav-0.95 (#264820)
		myconf="${myconf} --enable-clamd
			--with-proxyuser=clamav
			--with-proxygroup=clamav"
	else
		myconf="${myconf}
			--with-proxyuser=dansguardian
			--with-proxygroup=dansguardian"
	fi
	if use kaspersky; then
		myconf="${myconf} --enable-kavd"
	fi
	if use debug; then
		myconf="${myconf} --with-dgdebug=on"
	fi

	econf ${myconf} || die "configure failed"
}

src_compile() {
	emake OPTIMISE="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake "DESTDIR=${D}" install || die "emake install failed"

	# Move html documents to html dir
	mkdir "${D}"/usr/share/doc/${PF}/html \
		&& mv "${D}"/usr/share/doc/${PF}/*.html "${D}"/usr/share/doc/${PF}/html \
		|| die "no html docs found in docdir"

	# Copying init script
	newinitd "${FILESDIR}/dansguardian.init" dansguardian

	if use clamav; then
		sed -r -i -e 's/[ \t]+use dns/& clamd/' "${D}/etc/init.d/dansguardian"
		sed -r -i -e 's/^#( *contentscanner *=.*clamdscan[.]conf.*)/\1/' "${D}/etc/dansguardian/dansguardian.conf"
		sed -r -i -e 's/^#( *clamdudsfile *=.*)/\1/' "${D}/etc/dansguardian/contentscanners/clamdscan.conf"
	elif use kaspersky; then
		sed -r -i -e 's/^#( *contentscanner *=.*kavdscan[.]conf.*)/\1/' "${D}/etc/dansguardian/dansguardian.conf"
	fi

	# Copying logrotation file
	insinto /etc/logrotate.d
	newins "${FILESDIR}/dansguardian.logrotate" dansguardian

	keepdir /var/log/dansguardian
	fperms o-rwx /var/log/dansguardian
}

pkg_postinst() {
	local runas="dansguardian:dansguardian"
	if use clamav ; then
		runas="clamav:clamav"
	else
		elog "dansguardian runs as a dedicated user now"
		elog "You may need to remove old ipc files or adjust their ownership."
		elog "By default, those files are /tmp/.dguardianipc"
		elog "and /tmp/.dguardianurlipc"
	fi
	einfo "The dansguardian daemon will run by default as ${runas}"

	if [ -d "${ROOT}/var/log/dansguardian" ] ; then
		chown -R ${runas} "${ROOT}/var/log/dansguardian"
		chmod o-rwx "${ROOT}/var/log/dansguardian"
	fi
}
