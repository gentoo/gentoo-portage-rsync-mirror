# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-3.3.5-r1.ebuild,v 1.1 2012/06/08 18:50:14 mr_bones_ Exp $

EAPI=2
inherit autotools eutils multilib

MY_PV=${PV/_/}
DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/files/syslog-ng/sources/${MY_PV}/source/syslog-ng_${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="caps hardened ipv6 json mongodb +pcre selinux spoof-source sql ssl static tcpd"
RESTRICT="test"

LIBS_DEPEND="
	spoof-source? ( net-libs/libnet )
	ssl? ( dev-libs/openssl )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	!static? (
		>=dev-libs/eventlog-0.2.12
		>=dev-libs/glib-2.10.1:2 )
	json? ( >=dev-libs/json-glib-0.12 )
	caps? ( sys-libs/libcap )
	sql? ( >=dev-db/libdbi-0.8.3 )"
RDEPEND="
	!static? (
		pcre? ( dev-libs/libpcre )
		${LIBS_DEPEND}
	)"
DEPEND="${RDEPEND}
	${LIBS_DEPEND}
	static? (
		>=dev-libs/eventlog-0.2.12[static-libs]
		>=dev-libs/glib-2.10.1:2[static-libs] )
	virtual/pkgconfig
	sys-devel/flex"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-compile.patch \
		"${FILESDIR}"/${P}-afsocket.patch \
		"${FILESDIR}"/${P}-gprocess.patch \
		"${FILESDIR}"/${P}-include.patch \
		"${FILESDIR}"/${P}-threading.patch \
		"${FILESDIR}"/${P}-utmpx.patch
	sed -i \
		-e '/libsyslog_ng_crypto_la_LIBADD/s/$/ -lssl -lcrypto/' \
		lib/Makefile.am || die
	eautoreconf
}

src_configure() {
	local myconf

	if use static ; then
		myconf="${myconf} --enable-static-linking"
	else
		myconf="${myconf} --enable-dynamic-linking"
	fi
	econf \
		--disable-dependency-tracking \
		--disable-systemd \
		--with-ivykis=internal \
		--sysconfdir=/etc/syslog-ng \
		--localstatedir=/var/lib/misc \
		--with-pidfile-dir=/var/run \
		--with-module-dir=/usr/$(get_libdir)/syslog-ng \
		$(use_enable caps linux-caps) \
		$(use_enable ipv6) \
		$(use_enable json) \
		$(use_with json json-glib) \
		$(use_enable mongodb) \
		$(use_enable pcre) \
		$(use_enable spoof-source) \
		$(use_enable sql) \
		$(use_enable ssl) \
		$(use_enable tcpd tcp-wrapper) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS \
		contrib/syslog-ng.conf* \
		contrib/syslog2ng "${FILESDIR}/syslog-ng.conf."*

	# Install default configuration
	insinto /etc/syslog-ng
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.hardened.${PV%.*}" syslog-ng.conf || die
	elif use userland_BSD ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.fbsd.${PV%.*}" syslog-ng.conf || die
	else
		newins "${FILESDIR}/syslog-ng.conf.gentoo.${PV%.*}" syslog-ng.conf || die
	fi

	insinto /etc/logrotate.d
	# Install snippet for logrotate, which may or may not be installed
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.logrotate.hardened" syslog-ng || die
	else
		newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng || die
	fi

	newinitd "${FILESDIR}/syslog-ng.rc6.${PV%.*}" syslog-ng || die
	newconfd "${FILESDIR}/syslog-ng.confd" syslog-ng || die
	keepdir /etc/syslog-ng/patterndb.d
	find "${D}" -type f -name '*.la' -exec rm {} + || die
	rmdir "${D}"/usr/libexec
}

pkg_postinst() {
	elog "For detailed documentation please see the upstream website:"
	elog "http://www.balabit.com/sites/default/files/documents/syslog-ng-ose-3.3-guides/syslog-ng-ose-v3.3-guide-admin-en.html/index.html"

	# bug #355257
	if ! has_version app-admin/logrotate ; then
		echo
		elog "It is highly recommended that app-admin/logrotate be emerged to"
		elog "manage the log files.  ${PN} installs a file in /etc/logrotate.d"
		elog "for logrotate to use."
		echo
	fi
}
