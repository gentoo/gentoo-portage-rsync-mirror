# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/quassel/quassel-0.9.3.ebuild,v 1.7 2015/01/29 01:35:36 johu Exp $

EAPI=5

inherit cmake-utils eutils pax-utils user versionator

EGIT_REPO_URI="git://git.quassel-irc.org/quassel.git"
EGIT_BRANCH="master"
[[ "${PV}" == "9999" ]] && inherit git-2

QT_MINIMAL="4.6.0"
KDE_MINIMAL="4.4"

DESCRIPTION="Qt4/KDE4 IRC client supporting a remote daemon for 24/7 connectivity"
HOMEPAGE="http://quassel-irc.org/"
[[ "${PV}" == "9999" ]] || SRC_URI="http://quassel-irc.org/pub/${P/_/-}.tar.bz2"

LICENSE="GPL-3"
KEYWORDS="amd64 ~arm ~ppc x86 ~amd64-linux ~sparc-solaris"
SLOT="0"
IUSE="ayatana crypt dbus debug kde monolithic phonon postgres +server +ssl syslog webkit X"

SERVER_RDEPEND="
	>=dev-qt/qtscript-${QT_MINIMAL}:4
	crypt? ( app-crypt/qca:2[openssl,qt4(+)] )
	!postgres? ( >=dev-qt/qtsql-${QT_MINIMAL}:4[sqlite] dev-db/sqlite:3[threadsafe(+),-secure-delete] )
	postgres? ( >=dev-qt/qtsql-${QT_MINIMAL}:4[postgres] )
	syslog? ( virtual/logger )
"

GUI_RDEPEND="
	>=dev-qt/qtgui-${QT_MINIMAL}:4
	ayatana? ( dev-libs/libindicate-qt )
	dbus? (
		>=dev-qt/qtdbus-${QT_MINIMAL}:4
		dev-libs/libdbusmenu-qt
	)
	kde? (
		>=kde-base/kdelibs-${KDE_MINIMAL}
		|| ( kde-apps/oxygen-icons >=kde-base/oxygen-icons-${KDE_MINIMAL} )
		ayatana? ( kde-misc/plasma-widget-message-indicator )
	)
	phonon? ( || ( media-libs/phonon[qt4] >=dev-qt/qtphonon-${QT_MINIMAL}:4 ) )
	webkit? ( >=dev-qt/qtwebkit-${QT_MINIMAL}:4 )
"

RDEPEND="
	>=dev-qt/qtcore-${QT_MINIMAL}:4[ssl?]
	monolithic? (
		${SERVER_RDEPEND}
		${GUI_RDEPEND}
	)
	!monolithic? (
		server? ( ${SERVER_RDEPEND} )
		X? ( ${GUI_RDEPEND} )
	)
	"
DEPEND="${RDEPEND}
	kde? ( dev-util/automoc )"

DOCS="AUTHORS ChangeLog README"

S="${WORKDIR}/${P/_/-}"

REQUIRED_USE="
	|| ( X server monolithic )
	crypt? ( || ( server monolithic ) )
	postgres? ( || ( server monolithic ) )
	syslog? ( || ( server monolithic ) )
	kde? ( || ( X monolithic ) )
	phonon? ( || ( X monolithic ) )
	dbus? ( || ( X monolithic ) )
	ayatana? ( || ( X monolithic ) )
	webkit? ( || ( X monolithic ) )
"

pkg_setup() {
	if use server; then
		QUASSEL_DIR=/var/lib/${PN}
		QUASSEL_USER=${PN}
		# create quassel:quassel user
		enewgroup "${QUASSEL_USER}"
		enewuser "${QUASSEL_USER}" -1 -1 "${QUASSEL_DIR}" "${QUASSEL_USER}"
	fi
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_with ayatana LIBINDICATE)
		$(cmake-utils_use_want X QTCLIENT)
		$(cmake-utils_use_want server CORE)
		$(cmake-utils_use_want monolithic MONO)
		$(cmake-utils_use_with webkit)
		$(cmake-utils_use_with phonon)
		$(cmake-utils_use_with kde)
		$(cmake-utils_use_with dbus)
		$(cmake-utils_use_with ssl OPENSSL)
		$(cmake-utils_use_with syslog)
		$(cmake-utils_use_with !kde OXYGEN)
		$(cmake-utils_use_with crypt)
		"-DEMBED_DATA=OFF"
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	if use server ; then
		# needs PAX marking wrt bug#346255
		pax-mark m "${ED}/usr/bin/quasselcore"

		# prepare folders in /var/
		keepdir "${QUASSEL_DIR}"
		fowners "${QUASSEL_USER}":"${QUASSEL_USER}" "${QUASSEL_DIR}"

		# init scripts
		newinitd "${FILESDIR}"/quasselcore.init quasselcore
		newconfd "${FILESDIR}"/quasselcore.conf quasselcore

		# logrotate
		insinto /etc/logrotate.d
		newins "${FILESDIR}/quassel.logrotate" quassel
	fi
}

pkg_postinst() {
	if use monolithic && use ssl ; then
		elog "Information on how to enable SSL support for client/core connections"
		elog "is available at http://bugs.quassel-irc.org/wiki/quassel-irc."
	fi

	if use server; then
		einfo "If you want to generate SSL certificate remember to run:"
		einfo "	emerge --config =${CATEGORY}/${PF}"
	fi

	if use server || use monolithic ; then
		einfo "Quassel can use net-misc/oidentd package if installed on your system."
		einfo "Consider installing it if you want to run quassel within identd daemon."
	fi

	# temporary info mesage
	if use server && [[ $(get_version_component_range 2 ${REPLACING_VERSIONS}) -lt 7 ]]; then
		echo
		ewarn "Please note that all configuration moved from"
		ewarn "/home/\${QUASSEL_USER}/.config/quassel-irc.org/"
		ewarn "to: ${QUASSEL_DIR}."
		echo
		ewarn "For migration, stop the core, move quasselcore files (pretty much"
		ewarn "everything apart from quasselclient.conf and settings.qss) into"
		ewarn "new location and then start server again."
	fi
}

pkg_config() {
	if use server && use ssl; then
		# generate the pem file only when it does not already exist
		if [ ! -f "${QUASSEL_DIR}/quasselCert.pem" ]; then
			einfo "Generating QUASSEL SSL certificate to: \"${QUASSEL_DIR}/quasselCert.pem\""
			openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
				-keyout "${QUASSEL_DIR}/quasselCert.pem" \
				-out "${QUASSEL_DIR}/quasselCert.pem"
			# permissions for the key
			chown ${QUASSEL_USER}:${QUASSEL_USER} "${QUASSEL_DIR}/quasselCert.pem"
			chmod 400 "${QUASSEL_DIR}/quasselCert.pem"
		else
			einfo "Certificate \"${QUASSEL_DIR}/quasselCert.pem\" already exists."
			einfo "Remove it if you want to create new one."
		fi
	fi
}
