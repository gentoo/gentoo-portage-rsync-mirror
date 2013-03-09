# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dbus-test-runner/dbus-test-runner-12.10.1.ebuild,v 1.1 2013/03/09 06:51:05 dilfridge Exp $

EAPI=4

MY_MAJOR_VERSION=12.10

DESCRIPTION="Run executables under a new DBus session for testing"
HOMEPAGE="https://launchpad.net/dbus-test-runner"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="test"

RDEPEND="
	>=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.34
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	test? ( dev-util/bustle )
"
