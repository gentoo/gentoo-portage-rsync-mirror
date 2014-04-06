# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/map/map-6.5.3.ebuild,v 1.2 2014/04/05 23:08:26 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20 jruby"

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
		*jruby)
			epatch "${FILESDIR}/${PN}-6.5.1-ruby18-failing-tests.patch"
			;;
		*)
			;;
	esac
}
