# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openerp-server/openerp-server-5.0.16.ebuild,v 1.4 2014/12/28 15:00:08 titanofold Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils user

DESCRIPTION="Open Source ERP & CRM"
HOMEPAGE="http://www.openerp.com/"
SRC_URI="http://www.openerp.com/download/stable/source/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND="dev-db/postgresql[server]
	dev-python/egenix-mx-base
	dev-python/lxml
	dev-python/psycopg
	dev-python/pychart
	dev-python/pytz
	dev-python/pyxml
	dev-python/pyopenssl
	dev-python/reportlab
	media-gfx/pydot
	dev-libs/libxslt[python]
	dev-libs/libxml2[python]"

RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}"

OPENERP_USER="openerp"
OPENERP_GROUP="openerp"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install

	doinitd "${FILESDIR}/${PN}"
	newconfd "${FILESDIR}/openerp-server-confd" "${PN}"
	keepdir /var/run/openerp
	keepdir /var/log/openerp

	rm "${D}/usr/bin/openerp-server"

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/openerp-server.logrotate openerp-server || die
	dodir /etc/openerp
	insinto /etc/openerp
	newins "${FILESDIR}"/openerp-server.cfg openerp-server.cfg || die
}

pkg_preinst() {
	enewgroup ${OPENERP_GROUP}
	enewuser ${OPENERP_USER} -1 -1 -1 ${OPENERP_GROUP}

	fowners ${OPENERP_USER}:${OPENERP_GROUP} /var/run/openerp
	fowners ${OPENERP_USER}:${OPENERP_GROUP} /var/log/openerp
}

pkg_postinst() {
	elog "In order to setup the initial database, run:"
	elog " emerge --config =${CATEGORY}/${PF}"
	elog "Be sure the database is started before"
}

pquery() {
	psql -q -At -U postgres -d template1 -c "$@"
}

pkg_config() {
	einfo "In the following, the 'postgres' user will be used."
	if ! pquery "SELECT usename FROM pg_user WHERE usename = '${OPENERP_USER}'" | grep -q ${OPENERP_USER}; then
		ebegin "Creating database user ${OPENERP_USER}"
		createuser --username=postgres --createdb --no-adduser ${OPENERP_USER}
		eend $? || die "Failed to create database user"
	fi
}
