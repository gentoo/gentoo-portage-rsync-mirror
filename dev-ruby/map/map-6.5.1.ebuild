# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/map/map-6.5.1.ebuild,v 1.1 2013/10/22 18:03:08 graaff Exp $

EAPI=5
USE_RUBY="ruby18 ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""

RUBY_FAKEGEM_EXTRADOC="README"

RUBY_FAKEGEM_GEMSPEC="map.gemspec"

inherit ruby-fakegem

DESCRIPTION="A string/symbol indifferent ordered hash that works in all rubies."
HOMEPAGE="http://github.com/ahoward/map"

LICENSE="|| ( Ruby BSD-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

each_ruby_prepare() {
	case ${RUBY} in
		*ruby18)
			epatch "${FILESDIR}/ruby18-failing-tests.patch"
			epatch "${FILESDIR}/${P}-ruby18-failing-tests.patch"
			;;
		*jruby)
			epatch "${FILESDIR}/${P}-ruby18-failing-tests.patch"
			;;
		*)
			;;
	esac
}
