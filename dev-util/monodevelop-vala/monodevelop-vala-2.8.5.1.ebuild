# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-vala/monodevelop-vala-2.8.5.1.ebuild,v 1.4 2012/05/22 12:19:29 ago Exp $

EAPI="4"

inherit mono multilib versionator

DESCRIPTION="Vala Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://download.mono-project.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=">=dev-lang/mono-2.4
	=dev-util/monodevelop-$(get_version_component_range 1-2)*
	>=dev-dotnet/mono-addins-0.4[gtk]
	>=dev-dotnet/glib-sharp-2.12.9
	>=dev-dotnet/gtk-sharp-2.12.9
	>=dev-dotnet/glade-sharp-2.12.9
	>=dev-dotnet/gnome-sharp-2.24.0
	>=dev-dotnet/gnomevfs-sharp-2.24.0
	>=dev-dotnet/gconf-sharp-2.24.0
	dev-lang/vala:0.14"

DEPEND="${RDEPEND}
	x11-misc/shared-mime-info
	>=dev-util/intltool-0.35
	virtual/pkgconfig"

src_prepare() {
	# http://bugzilla.xamarin.com/show_bug.cgi?id=1519
	cp "${FILESDIR}"/MonoDevelop.ValaBinding.dll.config . || die

	# Doesn't really require so old vala:0, see upstream bug #667923
	sed -i -e s:valac:$(type -P valac-0.14): Compiler/ValaCompiler.cs \
		templates/Makefile.am.template templates/Makefile.template || die
	sed -i -e s:vala-0.12:vala-0.14: configure.in configure \
		MonoDevelop.ValaBinding.dll.config || die
}

src_compile() {
	emake -j1
}

src_install() {
	default
	mono_multilib_comply
}
