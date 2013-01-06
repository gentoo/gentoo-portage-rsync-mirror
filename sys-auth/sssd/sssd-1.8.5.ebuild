# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/sssd/sssd-1.8.5.ebuild,v 1.1 2012/10/14 10:58:38 pinkbyte Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.6"

inherit python multilib pam linux-info autotools-utils

DESCRIPTION="System Security Services Daemon provides access to identity and authentication"
HOMEPAGE="http://fedorahosted.org/sssd/"
SRC_URI="http://fedorahosted.org/released/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc +locator netlink nls python selinux test"

COMMON_DEP="
	virtual/pam
	dev-libs/popt
	dev-libs/glib:2
	>=dev-libs/ding-libs-0.1.2
	>=sys-libs/talloc-2.0
	sys-libs/tdb
	sys-libs/tevent
	sys-libs/ldb
	>=net-nds/openldap-2.4.19
	!!~net-nds/openldap-2.4.28
	dev-libs/libpcre
	>=app-crypt/mit-krb5-1.9.1
	sys-apps/keyutils
	>=net-dns/c-ares-1.7.4
	>=dev-libs/nss-3.12.9
	selinux? (
		>=sys-libs/libselinux-2.0.94
		>=sys-libs/libsemanage-2.0.45
		sec-policy/selinux-sssd
	)
	net-dns/bind-tools
	dev-libs/cyrus-sasl
	sys-apps/dbus
	nls? ( >=sys-devel/gettext-0.17 )
	virtual/libintl
	netlink? ( dev-libs/libnl )
	"

RDEPEND="${COMMON_DEP}"
DEPEND="${COMMON_DEP}
	test? ( dev-libs/check )
	>=dev-libs/libxslt-1.1.26
	app-text/docbook-xml-dtd:4.4
	doc? ( app-doc/doxygen )"

CONFIG_CHECK="~KEYS"

pkg_setup(){
	if use python; then
		python_set_active_version 2
		python_pkg_setup
		python_need_rebuild
	fi
	linux-info_pkg_setup
}

src_prepare() {
	cp -f  "${FILESDIR}"/sssd "${S}/"src/sysv/gentoo/sssd
}

src_configure(){
	local myeconfargs=(
		--localstatedir="${EPREFIX}"/var
		--enable-nsslibdir="${EPREFIX}"/$(get_libdir)
		--with-plugin-path="${EPREFIX}"/usr/$(get_libdir)/sssd
		--enable-pammoddir="${EPREFIX}"/$(getpam_mod_dir)
		--with-ldb-lib-dir="${EPREFIX}"/usr/$(get_libdir)/ldb/modules/ldb
		--without-nscd
		--with-unicode-lib="glib2"
		$(use_with selinux)
		$(use_with selinux semanage)
		$(use_with python python-bindings)
		$(use_enable locator krb5-locator-plugin)
		$(use_enable nls )
		$(use_with netlink libnl) )

	autotools-utils_src_configure
}

src_install(){
	autotools-utils_src_install
	remove_libtool_files all

	insinto /etc/sssd
	insopts -m600
	doins "${S}"/src/examples/sssd-example.conf

	insinto /etc/logrotate.d
	insopts -m644
	newins "${S}"/src/examples/logrotate sssd

	if use python; then
		python_clean_installation_image
		python_convert_shebangs 2 "${ED}$(python_get_sitedir)/"*.py
	fi
	newconfd "${FILESDIR}"/sssd.conf sssd
}

src_test() {
	autotools-utils_src_test
}

pkg_postinst(){
	elog "You must set up sssd.conf (default installed into /etc/sssd)"
	elog "and (optionally) configuration in /etc/pam.d in order to use SSSD"
	elog "features. Please see howto in	http://fedorahosted.org/sssd/wiki/HOWTO_Configure_1_0_2"

	use python && python_mod_optimize SSSDConfig.py ipachangeconf.py
}

pkg_postrm() {
	use python && python_mod_cleanup SSSDConfig.py ipachangeconf.py
}
