# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/cinnamon-translations/cinnamon-translations-2.2.4.ebuild,v 1.2 2014/12/18 14:56:46 pacho Exp $

EAPI=5

PLOCALES="af am an ar as ast az be be@latin bg bn bn_IN br bs ca ca@valencia crh cs csb cy da de dz el en_AU en_CA en_GB en@shaw eo es es_AR et eu fa fi fil fo fr fr_CA ga gd gl gu he hi hr hu hy ia id is it ja jv ka kk km kn ko ksw ku ky la li lo lt lv mai mg mk ml mn mr ms my nb nds ne nl nn nso oc om or pa pl ps pt pt_BR ro ru rue rw shn si sk sl so sq sr sr@ijekavianlatin sr@latin sv ta te tg th tlh tpi tr ts ug uk ur uz uz@cyrillic vi wa xh yi zh_CN zh_HK zh_TW zu"

inherit eutils l10n

DESCRIPTION="Translation data for Cinnamon"
HOMEPAGE="http://cinnamon.linuxmint.com/"
SRC_URI="https://github.com/linuxmint/cinnamon-translations/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""
RESTRICT="test" # tests are for upstream translators and need network access

src_prepare() {
	l10n_find_plocales_changes "${S}/mo-export" "" ""
	epatch_user
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	install_locale() {
		# Cinnamon components use LOCALEDIR=$datadir/cinnamon/locale
		dodir "/usr/share/cinnamon/locale"
		insinto "/usr/share/cinnamon/locale"
		doins -r "mo-export/${1}"
	}
	l10n_for_each_locale_do install_locale
}
