# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/dbus-test-runner/dbus-test-runner-0.0.5.ebuild,v 1.8 2013/01/06 09:31:47 ago Exp $

EAPI=4

MY_MAJOR_VERSION=trunk

DESCRIPTION="Run executables under a new DBus session for testing"
HOMEPAGE="https://launchpad.net/dbus-test-runner"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJOR_VERSION}/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="test"

RDEPEND="
	>=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.30
"
DEPEND="
	${RDEPEND}
	dev-util/intltool
	test? ( dev-util/bustle )
"
