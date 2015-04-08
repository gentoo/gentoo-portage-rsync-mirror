# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/firewalld/firewalld-0.3.10.ebuild,v 1.1 2014/06/17 12:50:57 dev-zero Exp $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3} )
#BACKPORTS=190680ba

inherit autotools eutils gnome2-utils python-r1 systemd multilib bash-completion-r1

DESCRIPTION="A firewall daemon with D-BUS interface providing a dynamic firewall"
HOMEPAGE="http://fedorahosted.org/firewalld"
SRC_URI="https://fedorahosted.org/released/firewalld/${P}.tar.bz2
	${BACKPORTS:+http://dev.gentoo.org/~cardoe/distfiles/${P}-${BACKPORTS}.tar.xz}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gui"

RDEPEND="${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/decorator[${PYTHON_USEDEP}]
	>=dev-python/python-slip-0.2.7[dbus,${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	net-firewall/ebtables
	net-firewall/iptables[ipv6]
	|| ( >=sys-apps/openrc-0.11.5 sys-apps/systemd )
	gui? ( x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	dev-libs/glib:2
	>=dev-util/intltool-0.35
	sys-devel/gettext"

src_prepare() {
	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	epatch "${FILESDIR}/${P}-py3k-compat.patch"
	epatch_user
	eautoreconf
}

src_configure() {
	python_export_best

	econf \
		--enable-systemd \
		"$(systemd_with_unitdir 'systemd-unitdir')" \
		--with-bashcompletiondir="$(get_bashcompdir)"
}

src_install() {
	# manually split up the installation to avoid "file already exists" errors
	emake -C config DESTDIR="${ED}" install
	emake -C po DESTDIR="${ED}" install
	emake -C shell-completion DESTDIR="${ED}" install

	install_python() {
		emake -C src DESTDIR="${ED}" pythondir="$(python_get_sitedir)" install
		python_optimize
	}
	python_foreach_impl install_python

	python_replicate_script "${ED}"/usr/bin/firewall-{offline-cmd,cmd,applet,config}
	python_replicate_script "${ED}/usr/sbin/firewalld"

	# Get rid of junk
	rm -f "${ED}/etc/rc.d/init.d/firewalld"
	rm -f "${ED}/etc/sysconfig/firewalld"
	rm -rf "${ED}/etc/rc.d/"
	rm -rf "${ED}/etc/sysconfig/"

	# For non-gui installs we need to remove GUI bits
	if ! use gui; then
		rm -f "${ED}/usr/bin/firewall-applet"
		rm -f "${ED}/usr/bin/firewall-config"
		rm -rf "${ED}/usr/share/icons"
		rm -rf "${ED}/usr/share/applications"
	fi

	newinitd "${FILESDIR}"/firewalld.init firewalld
}

pkg_preinst() {
	gnome2_icon_savelist
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_icon_cache_update
	gnome2_schemas_update
}
