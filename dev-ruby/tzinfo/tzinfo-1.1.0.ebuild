# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/tzinfo/tzinfo-1.1.0.ebuild,v 1.5 2014/04/22 03:20:18 mrueg Exp $

EAPI=5
USE_RUBY="ruby19 ruby20"

RUBY_FAKEGEM_RECIPE_DOC="rdoc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGES.md README.md"

inherit ruby-fakegem

DESCRIPTION="Daylight-savings aware timezone library"
HOMEPAGE="http://tzinfo.rubyforge.org/"

LICENSE="MIT"
SLOT="1"
KEYWORDS="~amd64 ~arm ~hppa ~x86"
IUSE=""

RDEPEND="sys-libs/timezone-data"
DEPEND="test? ( sys-libs/timezone-data )"

ruby_add_rdepend ">=dev-ruby/thread_safe-0.1:0"

all_ruby_prepare() {
	# With rubygems 1.3.1 we get the following warning
	# warning: Insecure world writable dir /var/tmp in LOAD_PATH, mode 041777
	# when running the test_get_tainted_not_loaded test.
	sed -i \
		-e '/^    def test_get_tainted_not_loaded/, /^    end/ s:^:#:' \
		-e '/test_get_tainted_not_previously_loaded/,/^  end/ s:^:#:' \
		"${S}"/test/tc_timezone.rb || die "unable to sed out the test"

	sed -i \
		-e '/test_load_timezone_info_tainted/,/^  end/ s:^:#:' \
		test/tc_ruby_data_source.rb || die
}

each_ruby_test() {
	TZ='America/Los_Angeles' ${RUBY} -I. -S testrb test/tc_*.rb || die
}
