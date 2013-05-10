# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/myodbc/myodbc-5.1.6.ebuild,v 1.8 2013/05/10 08:17:39 patrick Exp $

EAPI=2
inherit eutils versionator autotools

MAJOR="$(get_version_component_range 1-2 $PV)"
MY_PN="mysql-connector-odbc"
MY_P="${MY_PN}-${PV/_p/r}"
DESCRIPTION="ODBC driver for MySQL"
HOMEPAGE="http://www.mysql.com/products/myodbc/"
SRC_URI="mirror://mysql/Downloads/Connector-ODBC/${MAJOR}/${MY_P}.tar.gz"
RESTRICT="primaryuri"
LICENSE="GPL-2"
SLOT="${MAJOR}"
KEYWORDS="amd64 ppc x86"
IUSE="debug doc static qt4"
RDEPEND=">=virtual/mysql-4.0
		 dev-db/unixODBC
		 qt4? ( >=dev-qt/qtgui-4:4 )"
# perl is required for building docs
DEPEND="${RDEPEND}
		doc? ( dev-lang/perl )"
S=${WORKDIR}/${MY_P}

# Careful!
DRIVER_NAME="${PN}-${SLOT}"

src_prepare() {
	epatch "${FILESDIR}"/myodbc-5.1.6-qt4-includedir.patch
	eautoreconf
}

src_configure() {
	local myconf="--enable-static"
	use static \
		&& myconf="${myconf} --disable-shared" \
		|| myconf="${myconf} --enable-shared"

	myconf="${myconf} $(use_with doc docs) $(use_with debug)"
	#myconf="${myconf} --disable-gui"
	#TODO: the configure test against qt 4 enter in an endless loop
	myconf="${myconf}
			$(use_enable qt4 gui)
			$(use_with qt4 qt-libraries /usr/$(get_libdir)/qt4/)"

	econf \
		--libexecdir=/usr/sbin \
		--sysconfdir=/etc/myodbc \
		--localstatedir=/var/lib/myodbc \
		--with-mysql-libs=/usr/lib/mysql \
		--with-mysql-includes=/usr/include/mysql \
		--with-odbc-ini=/etc/unixODBC/odbc.ini \
		--with-unixODBC=/usr \
		--enable-myodbc3i \
		--enable-myodbc3m \
		--disable-test \
		--without-samples \
		${myconf} \
		|| die "econf failed"
}

src_compile() {
	emake \
	|| die "emake failed"
}

src_install() {
	into /usr
	einstall \
		libexecdir="${D}"/usr/sbin \
		sysconfdir="${D}"/etc/myodbc \
		localstatedir="${D}"/var/lib/myodbc \
		pkgdatadir="${D}"/usr/share/doc/${PF}
	dodoc INSTALL README
	prepalldocs
	dodir /usr/share/${PN}-${SLOT}
	for i in odbc.ini odbcinst.ini; do
		einfo "Building $i"
			sed \
			-e "s,__PN__,${DRIVER_NAME},g" \
			-e "s,__PF__,${PF},g" \
			-e "s,libmyodbc3.so,libmyodbc${SLOT:0:1}.so,g" \
			>"${D}"/usr/share/${PN}-${SLOT}/${i} \
			<"${FILESDIR}"/${i}.m4 \
			|| die "Failed to build $i"
	done;
}

pkg_config() {
	[ "${ROOT}" != "/" ] && \
	die 'Sorry, non-standard ROOT setting is not supported :-('

	local msg='MySQL ODBC driver'
	local drivers=$(/usr/bin/odbcinst -q -d)
	if echo $drivers | grep -vq "^\[${DRIVER_NAME}\]$" ; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -d -f /usr/share/${PN}-${SLOT}/odbcinst.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi

	local sources=$(/usr/bin/odbcinst -q -s)
	msg='sample MySQL ODBC DSN'
	if echo $sources | grep -vq "^\[${DRIVER_NAME}-test\]$"; then
		ebegin "Installing ${msg}"
		/usr/bin/odbcinst -i -s -l -f /usr/share/${PN}-${SLOT}/odbc.ini
		rc=$?
		eend $rc
		[ $rc -ne 0 ] && die
	else
		einfo "Skipping already installed ${msg}"
	fi
}

pkg_postinst() {
	elog "If this is a new install, please run the following command"
	elog "to configure the MySQL ODBC drivers and sources:"
	elog "emerge --config =${CATEGORY}/${PF}"
	elog "Please note that the driver name used to form the DSN now includes the SLOT."
}
