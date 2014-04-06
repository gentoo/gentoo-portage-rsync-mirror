# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/right_http_connection/right_http_connection-1.3.0.ebuild,v 1.7 2014/04/05 23:06:58 mrueg Exp $

EAPI=4

USE_RUBY="ruby19 ruby20 jruby"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_EXTRADOC="README.txt History.txt"

RUBY_FAKEGEM_TASK_TEST="cucumber"

inherit ruby-fakegem

DESCRIPTION="RightScale's robust HTTP/S connection module"
HOMEPAGE="http://rightscale.rubyforge.org/"
SRC_URI="https://github.com/rightscale/right_http_connection/tarball/v${PV} -> ${P}.tgz"
RUBY_S="rightscale-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE=""

RESTRICT="test"
#USE_RUBY="ruby19" ruby_add_bdepend "test? ( dev-util/cucumber )"

all_ruby_prepare() {
	rm Gemfile Gemfile.lock || die
	sed -i -e '/bundler/ s:^:#:' features/support/env.rb || die
}

each_ruby_test() {
	case ${RUBY} in
		*ruby19)
			;;
		*jruby)
			;;
		*)
			${RUBY} -S cucumber features || die
			;;
	esac
}
