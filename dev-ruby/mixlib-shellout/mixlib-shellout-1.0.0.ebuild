# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/mixlib-shellout/mixlib-shellout-1.0.0.ebuild,v 1.4 2014/04/05 23:31:18 mrueg Exp $

EAPI=4
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_RECIPE_TEST="rspec"

RUBY_FAKEGEM_EXTRA_DOC="README.md"

inherit ruby-fakegem

DESCRIPTION="Run external commands on Unix or Windows"
HOMEPAGE="http://github.com/opscode/mixlib-shellout"
SRC_URI="https://github.com/opscode/${PN}/tarball/${PV} -> ${P}.tgz"
RUBY_S="opscode-${PN}-*"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
