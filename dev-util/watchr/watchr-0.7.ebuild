# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/watchr/watchr-0.7.ebuild,v 1.2 2014/08/14 13:59:15 mrueg Exp $

EAPI=5
USE_RUBY="ruby19"

RUBY_FAKEGEM_TASK_DOC=""

# Requires every which we don't have packaged.
RUBY_FAKEGEM_TASK_TEST=""

inherit ruby-fakegem

DESCRIPTION="Modern continuous testing (flexible alternative to Autotest)"
HOMEPAGE="http://mynyml.com/ruby/flexible-continuous-testing"
LICENSE="MIT"

KEYWORDS="~amd64 ~x86 ~x86-macos"
SLOT="0"
IUSE=""

# This is an optional dependency, but highly recommended on unix systems
ruby_add_rdepend "dev-ruby/rev"
