# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/ufw-frontends/ufw-frontends-0.3.2-r1.ebuild,v 1.1 2014/02/15 10:34:57 hwoarang Exp $

EAPI=5
PYTHON_COMPAT=( python2_6 python2_7 )
inherit distutils-r1

DESCRIPTION="Provides graphical frontend to ufw"
HOMEPAGE="http://code.google.com/p/ufw-frontends/"
SRC_URI="http://ufw-frontends.googlecode.com/files/${P}.tar.gz"

# CC-BY-NC-SA-3.0 is for a png file
LICENSE="GPL-3 CC-BY-NC-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kde policykit"

DEPEND=""
RDEPEND="${DEPEND}
	dev-python/pygobject:2[${PYTHON_USEDEP}]
	dev-python/pygtk[${PYTHON_USEDEP}]
	dev-python/pyinotify[${PYTHON_USEDEP}]
	net-firewall/ufw
	!policykit? (
		kde? ( kde-base/kdesu ) )
	policykit? ( sys-auth/polkit )
"

python_prepare_all() {
	if use policykit; then
		sed -i 's/^Exec=su-to-root -X -c/Exec=pkexec/' \
			share/ufw-gtk.desktop || die
	elif use kde; then
		sed -i 's/^Exec=su-to-root -X -c/Exec=kdesu/' \
			share/ufw-gtk.desktop || die
	fi

	# don't try to override run() to install the script
	# under /usr/sbin; it does not work with distutils-r1
	# and so it is handled differently (in python_install)
	sed -i '/cmdclass=/d' setup.py || die

	# Qt version is unusable
	rm gfw/frontend_qt.py || die
	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install --install-scripts="/usr/sbin"
}

python_install_all() {
	distutils-r1_python_install_all

	if use policykit; then
		insinto /usr/share/polkit-1/actions/
		doins "${FILESDIR}"/org.gentoo.pkexec.ufw-gtk.policy
	elif ! use kde; then
		rm "${D}usr/share/applications/ufw-gtk.desktop" || die
	fi
}
