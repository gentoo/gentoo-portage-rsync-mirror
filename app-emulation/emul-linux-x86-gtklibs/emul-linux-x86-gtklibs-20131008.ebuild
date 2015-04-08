# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-gtklibs/emul-linux-x86-gtklibs-20131008.ebuild,v 1.2 2013/11/22 19:30:48 pacho Exp $

EAPI=5
inherit emul-linux-x86

LICENSE="GPL-2 LGPL-2 FTL LGPL-2.1 LGPL-3 MPL-1.1 MIT"
KEYWORDS="-* amd64"

DEPEND=""
RDEPEND="~app-emulation/emul-linux-x86-baselibs-${PV}
	~app-emulation/emul-linux-x86-xlibs-${PV}
	~app-emulation/emul-linux-x86-opengl-${PV}"
# RDEPEND on opengl stuff needed due cairo, bug #410213

my_gdk_pixbuf_query_loaders() {
	# causes segfault if set
	unset __GL_NO_DSO_FINALIZER

	local tmp_file=$(mktemp --suffix=tmp.XXXXXXXXXXgdk_pixbuf_queryloaders)
	if [ -z "${tmp_file}" ]; then
		ewarn "Cannot create temporary file"
		return 1
	fi

	if gdk-pixbuf-query-loaders32 > "${tmp_file}"; then
		cat "${tmp_file}" > "${ROOT}usr/lib32/gdk-pixbuf-2.0/2.10.0/loaders.cache"
	else
		ewarn "Warning, gdk-pixbuf-query-loaders32 failed."
	fi
	rm "${tmp_file}"
}

my_pango_querymodules() {
	PANGO_CONFDIR="/etc/pango/i686-pc-linux-gnu"
	einfo "Generating pango modules listing..."

	mkdir -p "${PANGO_CONFDIR}"
	local pango_conf="${PANGO_CONFDIR}/pango.modules"
	local tmp_file=$(mktemp -t tmp.XXXXXXXXXXpango_querymodules)
	if [ -z "${tmp_file}" ]; then
		ewarn "Cannot create temporary file"
		return 1
	fi

	if pango-querymodules32 > "${tmp_file}"; then
		cat "${tmp_file}" > "${pango_conf}"
	else
		ewarn "Cannot update pango.modules, file generation failed"
	fi
	rm "${tmp_file}"
}

my_gtk_query_immodules() {
	GTK2_CONFDIR="/etc/gtk-2.0/i686-pc-linux-gnu"
	einfo "Generating gtk+ immodules/gdk-pixbuf loaders listing..."

	mkdir -p "${GTK2_CONFDIR}"
	local gtk_conf="${ROOT}${GTK2_CONFDIR}/gtk.immodules"
	local tmp_file=$(mktemp -t tmp.XXXXXXXXXXgtk_query_immodules)
	if [ -z "${tmp_file}" ]; then
		ewarn "Cannot create temporary file"
		return 1
	fi

	if gtk-query-immodules-2.0-32 > "${tmp_file}"; then
		cat "${tmp_file}" > "${gtk_conf}"
	else
		ewarn "Cannot update gtk.immodules, file generation failed"
	fi
	rm "${tmp_file}"
}

src_prepare() {
	query_tools="${S}/usr/bin/gtk-query-immodules-2.0|${S}/usr/bin/gdk-pixbuf-query-loaders|${S}/usr/bin/pango-querymodules"
	ALLOWED="(${S}/etc/env.d|${S}/etc/gtk-2.0|${S}/etc/pango/i686-pc-linux-gnu|${query_tools})"
	emul-linux-x86_src_prepare

	# these tools generate an index in /etc/{pango,gtk-2.0}/${CHOST}
	mv -f "${S}/usr/bin/pango-querymodules"{,32} || die
	mv -f "${S}/usr/bin/gtk-query-immodules-2.0"{,-32} || die
	mv -f "${S}/usr/bin/gdk-pixbuf-query-loaders"{,32} || die
}

pkg_preinst() {
	#bug 169058
	for l in "${ROOT}/usr/lib32/{pango,gtk-2.0}" ; do
		[[ -L ${l} ]] && rm -f ${l}
	done
}

pkg_postinst() {
	my_pango_querymodules
	my_gtk_query_immodules
	my_gdk_pixbuf_query_loaders

	# gdk-pixbuf.loaders should be in their CHOST directories respectively.
	if [[ -e "${ROOT}/etc/gtk-2.0/gdk-pixbuf.loaders" ]] ; then
		ewarn
		ewarn "File /etc/gtk-2.0/gdk-pixbuf.loaders shouldn't be present on"
		ewarn "multilib systems, please remove it by hand."
		ewarn
	fi
}
