# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp/openerp-7.0.20130118.ebuild,v 1.1 2013/01/21 08:54:18 patrick Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit eutils distutils

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
#yes, this is definitely a horrible URI
MY_PV=${PV/7.0./7.0-}
FNAME="${PN}-${MY_PV}-002240"
SRC_URI="http://nightly.openerp.com/7.0/nightly/src/${FNAME}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+postgres ldap ssl"

CDEPEND="postgres? ( dev-db/postgresql-server )
	dev-python/psutil
	dev-python/docutils
	dev-python/lxml
	dev-python/psycopg:2
	dev-python/pychart
	dev-python/reportlab
	media-gfx/pydot
	dev-python/vobject
	dev-python/mako
	dev-python/pyyaml
	dev-python/Babel
	dev-python/gdata
	ldap? ( dev-python/python-ldap )
	dev-python/python-openid
	dev-python/werkzeug
	dev-python/xlwt
	dev-python/feedparser
	dev-python/python-dateutil
	dev-python/pywebdav
	ssl? ( dev-python/pyopenssl )
	dev-python/vatnumber
	dev-python/zsi"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

OPENERP_USER="openerp"
OPENERP_GROUP="openerp"

S="${WORKDIR}/${FNAME}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install

	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/openerp-confd" "${PN}"
	keepdir /var/run/openerp
	keepdir /var/log/openerp

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/openerp.logrotate openerp || die
	dodir /etc/openerp
	insinto /etc/openerp
	newins "${FILESDIR}"/openerp.cfg openerp.cfg || die
}

pkg_preinst() {
	enewgroup ${OPENERP_GROUP}
	enewuser ${OPENERP_USER} -1 -1 -1 ${OPENERP_GROUP}

	fowners ${OPENERP_USER}:${OPENERP_GROUP} /var/run/openerp
	fowners ${OPENERP_USER}:${OPENERP_GROUP} /var/log/openerp
	fowners -R ${OPENERP_USER}:${OPENERP_GROUP} "$(python_get_sitedir)/${PN}/addons/"

	use postgres || sed -i '6,8d' "${D}/etc/init.d/openerp" || die "sed failed"
}

pkg_postinst() {
	chown ${OPENERP_USER}:${OPENERP_GROUP} /var/run/openerp
	chown ${OPENERP_USER}:${OPENERP_GROUP} /var/log/openerp
	chown -R ${OPENERP_USER}:${OPENERP_GROUP} "$(python_get_sitedir)/${PN}/addons/"

	elog "In order to setup the initial database, run:"
	elog " emerge --config =${CATEGORY}/${PF}"
	elog "Be sure the database is started before"
}

psqlquery() {
	psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
	einfo "In the following, the 'postgres' user will be used."
	if ! psqlquery "SELECT usename FROM pg_user WHERE usename = '${OPENERP_USER}'" | grep -q ${OPENERP_USER}; then
		ebegin "Creating database user ${OPENERP_USER}"
		createuser --username=postgres --createdb --no-adduser ${OPENERP_USER}
		eend $? || die "Failed to create database user"
	fi
}
