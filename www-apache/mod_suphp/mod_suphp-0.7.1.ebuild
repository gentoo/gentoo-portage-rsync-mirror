# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_suphp/mod_suphp-0.7.1.ebuild,v 1.2 2014/08/10 20:18:02 slyfox Exp $

EAPI="2"

inherit apache-module confutils

DESCRIPTION="suPHP is a tool for executing PHP scripts with the permissions of their owners"
HOMEPAGE="http://www.suphp.org/"
SRC_URI="http://www.suphp.org/download/suphp-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="checkpath mode-force mode-owner +mode-paranoid"

S="${WORKDIR}/suphp-${PV}"

APXS2_S="${S}/src/apache2"
APACHE2_MOD_CONF="70_${PN}"
APACHE2_MOD_DEFINE="SUPHP"

need_apache2_2

pkg_setup() {
	confutils_require_one mode-force mode-owner mode-paranoid

	if use mode-force; then
		SUPHP_SETIDMODE="force"
	elif use mode-owner; then
		SUPHP_SETIDMODE="owner"
	else
		SUPHP_SETIDMODE="paranoid"
	fi

	elog
	elog "Using ${SUPHP_SETIDMODE} mode"
	elog
	elog "You can manipulate several configure options of this"
	elog "ebuild through environment variables:"
	elog
	elog "SUPHP_MINUID: Minimum UID, which is allowed to run scripts (default: 1000)"
	elog "SUPHP_MINGID: Minimum GID, which is allowed to run scripts (default: 100)"
	elog "SUPHP_APACHEUSER: Name of the user Apache is running as (default: apache)"
	elog "SUPHP_LOGFILE: Path to suPHP logfile (default: /var/log/apache2/suphp_log)"
	elog
}

src_configure() {
	local myargs=""
	use checkpath || myargs="--disable-checkpath"

	: ${SUPHP_MINUID:=1000}
	: ${SUPHP_MINGID:=100}
	: ${SUPHP_APACHEUSER:="apache"}
	: ${SUPHP_LOGFILE:="/var/log/apache2/suphp_log"}

	econf ${myargs} \
		--with-setid-mode=${SUPHP_SETIDMODE} \
		--with-min-uid=${SUPHP_MINUID} \
		--with-min-gid=${SUPHP_MINGID} \
		--with-apache-user=${SUPHP_APACHEUSER} \
		--with-logfile=${SUPHP_LOGFILE} \
		--with-apxs=${APXS} \
		--with-apr=/usr/bin/apr-1-config \
		|| die "econf failed"
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	apache-module_src_install
	dosbin src/suphp
	fperms 4755 /usr/sbin/suphp

	dodoc ChangeLog doc/CONFIG

	docinto apache
	dodoc doc/apache/CONFIG doc/apache/INSTALL

	insinto /etc
	doins "${FILESDIR}/suphp.conf"
}

pkg_postinst() {
	# Make sure the suphp binary is set setuid
	chmod 4755 "${ROOT}"/usr/sbin/suphp

	apache-module_pkg_postinst
}
