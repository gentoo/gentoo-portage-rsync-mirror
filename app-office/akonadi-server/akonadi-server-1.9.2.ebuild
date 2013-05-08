# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/akonadi-server/akonadi-server-1.9.2.ebuild,v 1.1 2013/05/08 18:38:22 johu Exp $

EAPI=5

if [[ $PV = *9999* ]]; then
	scm_eclass=git-2
	EGIT_REPO_URI="git://anongit.kde.org/akonadi"
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://kde/stable/${PN/-server/}/src/${P/-server/}.tar.bz2"
	KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
	S="${WORKDIR}/${P/-server/}"
fi

inherit cmake-utils ${scm_eclass}

DESCRIPTION="The server part of Akonadi"
HOMEPAGE="http://pim.kde.org/akonadi"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="+mysql postgres sqlite test"

CDEPEND="
	dev-libs/boost:=
	>=dev-libs/soprano-2.6.51
	>=dev-qt/qtgui-4.5.0:4[dbus]
	>=dev-qt/qtsql-4.5.0:4[mysql?,postgres?]
	>=dev-qt/qttest-4.5.0:4
	x11-misc/shared-mime-info
"
DEPEND="${CDEPEND}
	dev-libs/libxslt
	>=dev-util/automoc-0.9.88
"
RDEPEND="${CDEPEND}
	postgres? ( dev-db/postgresql-server )
"

REQUIRED_USE="|| ( sqlite mysql postgres )"

RESTRICT="test"

pkg_setup() {
	# Set default storage backend in order: MySQL, SQLite PostgreSQL
	# reverse driver check to keep the order
	if use postgres; then
		DRIVER="QPSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use sqlite; then
		DRIVER="QSQLITE3"
		AVAILABLE+=" ${DRIVER}"
	fi

	if use mysql; then
		DRIVER="QMYSQL"
		AVAILABLE+=" ${DRIVER}"
	fi

	# Notify about MySQL is recommend by upstream
	if use sqlite || has_version "<${CATEGORY}/${P}[sqlite]"; then
		ewarn
		ewarn "We strongly recommend you change your Akonadi database backend to MySQL in your"
		ewarn "user configuration. This is the backend recommended by KDE upstream."
		ewarn "In particular, kde-base/kmail-4.10 does not work properly with the sqlite"
		ewarn "backend anymore."
		ewarn "You can select the backend in your ~/.config/akonadi/akonadiserverrc."
		ewarn "Available drivers are:${AVAILABLE}"
		ewarn
	fi
}

src_configure() {
	local mycmakeargs=(
		-DAKONADI_USE_STRIGI_SEARCH=OFF
		-DINSTALL_QSQLITE_IN_QT_PREFIX=ON
		-DWITH_QT5=OFF
		$(cmake-utils_use test AKONADI_BUILD_TESTS)
		$(cmake-utils_use sqlite AKONADI_BUILD_QSQLITE)
	)

	cmake-utils_src_configure
}

src_install() {
	# Who knows, maybe it accidentally fixes our permission issues
	cat <<-EOF > "${T}"/akonadiserverrc
[%General]
Driver=${DRIVER}
EOF
	insinto /usr/share/config/akonadi
	doins "${T}"/akonadiserverrc

	cmake-utils_src_install
}

pkg_postinst() {
	elog "${DRIVER} has been set as your default akonadi storage backend."
	elog "You can override it in your ~/.config/akonadi/akonadiserverrc."
	elog "Available drivers are: ${AVAILABLE}"
}
