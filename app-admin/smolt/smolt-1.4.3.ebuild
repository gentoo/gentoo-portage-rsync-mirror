# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/smolt/smolt-1.4.3.ebuild,v 1.3 2012/12/02 22:51:09 ssuominen Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit python eutils

DESCRIPTION="The Fedora hardware profiler"
HOMEPAGE="https://fedorahosted.org/smolt/"
SRC_URI="https://fedorahosted.org/releases/s/m/${PN}/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4"

COMMON_DEPS="sys-devel/gettext"

DEPEND="${COMMON_DEPS}
	sys-apps/sed"

RDEPEND="${COMMON_DEPS}
	>=dev-python/rhpl-0.213
	>=dev-python/urlgrabber-3.0.0
	>=dev-python/simplejson-1.7.1
	sys-apps/pciutils
	sys-apps/usbutils
	virtual/udev
	qt4? ( dev-python/PyQt4 )"

S="${S}/client"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
	epatch "${FILESDIR}/${P}-makefile-py-files.patch" \
		"${FILESDIR}/${P}-hwdata-dir.patch" \
		"${FILESDIR}/${P}-disable-distro-data.patch"

	# Make it use {usb,pci}.ids of pciutils/usbutils
	sed -e "s:^#HWDATA_DIR = .*:HWDATA_DIR = \"${ROOT}/usr/share/misc\":" -i config.py || die
}

src_install() {
	emake install DESTDIR="${D}" DOCDIR="/usr/share/doc/${PF}" \
		|| die "Install failed"
	insinto "/usr/share/smolt/client"
	doins -r distros

	if ! use qt4; then
		rm "${D}"/usr/bin/smoltGui \
				"${D}"/usr/share/smolt/client/{gui,smoltGui}.py \
				"${D}"/usr/share/applications/smolt.desktop \
				"${D}"/usr/share/man/man1/smoltGui.1.* \
			|| die "rm failed"
		rmdir "${D}"/usr/share/applications || die "rmdir failed"
	fi

	bzip2 -9 "${D}"/usr/share/doc/${PF}/PrivacyPolicy || die "bzip2 failed"
	dodoc ../README ../TODO || die "dodoc failed"

	newinitd "${FILESDIR}"/${PN}-init.d ${PN} || die "newinitd failed"
}

pkg_postinst() {
	python_mod_optimize /usr/share/${PN}

	if ! [ -f "${ROOT}"/etc/smolt/hw-uuid ]; then
		elog "Creating this machines UUID in ${ROOT}etc/smolt/hw-uuid"
		cat /proc/sys/kernel/random/uuid > "${ROOT}"/etc/smolt/hw-uuid
	fi
	chmod 0444 "${ROOT}"/etc/smolt/hw-uuid
	UUID=$(cat "${ROOT}"/etc/smolt/hw-uuid)
	echo
	elog "Your UUID is: ${UUID}"
	echo
	elog "Call smoltSendProfile as root in order to initialize your profile."
	echo
	elog "You can withdraw it from the server if you wish to with"
	elog "   smoltDeleteProfile any time later on."
	echo

	if use qt4 && has_version "<dev-lang/python-2.5"; then
		elog "If you want to view your profile on the web from within smoltGui,"
		elog "you should have a link mozilla-firefox -> firefox in your path."
		echo
	fi
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
