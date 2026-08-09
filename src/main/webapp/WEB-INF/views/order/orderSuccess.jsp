<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - FashionStore</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/order.css">
    <style>
        .success-wrapper {
            max-width: 860px;
            margin: 0 auto;
            padding: 32px 24px 60px;
        }
        .success-banner {
            text-align: center;
            background: linear-gradient(135deg, #0F2447, #0E7490);
            border-radius: 16px;
            padding: 40px 32px;
            margin-bottom: 28px;
            color: var(--white);
        }
        .success-icon { font-size: 56px; margin-bottom: 16px; }
        .success-title {
            font-size: 24px;
            font-weight: 700;
            margin-bottom: 8px;
        }
        .success-subtitle {
            font-size: 14px;
            opacity: 0.85;
            margin-bottom: 20px;
        }
        .success-tracking {
            display: inline-block;
            background: rgba(255,255,255,0.15);
            border: 1px solid rgba(255,255,255,0.3);
            border-radius: 20px;
            padding: 8px 20px;
            font-size: 13px;
            font-weight: 600;
            letter-spacing: 1px;
        }
        .success-layout {
            display: grid;
            grid-template-columns: 1fr 300px;
            gap: 20px;
            align-items: start;
        }
        .success-card {
            background: var(--white);
            border-radius: 14px;
            padding: 22px;
            box-shadow: 0 2px 12px rgba(14,116,144,0.08);
            border: 1.5px solid var(--border);
            margin-bottom: 20px;
        }
        .success-card-title {
            font-size: 14px;
            font-weight: 700;
            color: var(--navy);
            margin-bottom: 16px;
            padding-bottom: 10px;
            border-bottom: 1px solid var(--border);
        }

        /* =============================================
           FIXED IMAGE SIZE
           ============================================= */
        .success-item {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 10px 0;
            border-bottom: 1px solid #F9FAFB;
        }
        .success-item:last-child { border-bottom: none; }

        .success-item-img {
            width: 60px !important;
            height: 60px !important;
            min-width: 60px !important;
            min-height: 60px !important;
            max-width: 60px !important;
            max-height: 60px !important;
            object-fit: cover !important;
            border-radius: 10px !important;
            background: var(--primary-bg);
            flex-shrink: 0 !important;
            border: 1px solid var(--border);
        }

        .success-item-info { flex: 1; min-width: 0; }
        .success-item-name {
            font-size: 13px;
            font-weight: 600;
            color: var(--navy);
            margin-bottom: 2px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .success-item-meta {
            font-size: 12px;
            color: var(--text-light);
            margin-bottom: 2px;
        }
        .success-item-price {
            font-size: 13px;
            font-weight: 700;
            color: var(--primary);
            white-space: nowrap;
            flex-shrink: 0;
        }

        /* =============================================
           ORDER INFO ROWS
           ============================================= */
        .success-info-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 9px 0;
            font-size: 13px;
            border-bottom: 1px solid #F9FAFB;
        }
        .success-info-row:last-child { border-bottom: none; }
        .success-info-row span:first-child { color: var(--text-light); }
        .success-info-row span:last-child {
            color: var(--navy);
            font-weight: 500;
            text-align: right;
        }
        .success-info-row.total span {
            font-size: 15px;
            font-weight: 700;
            color: var(--primary);
        }

        /* =============================================
           ACTION BUTTONS
           ============================================= */
        .success-actions {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }
        .btn-track {
            display: block;
            padding: 12px;
            background: var(--navy);
            color: var(--white);
            border-radius: var(--radius-lg);
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            transition: background 0.2s;
        }
        .btn-track:hover { background: var(--primary); }
        .btn-orders {
            display: block;
            padding: 12px;
            background: var(--white);
            color: var(--navy);
            border: 1.5px solid var(--border);
            border-radius: var(--radius-lg);
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-orders:hover {
            border-color: var(--primary);
            color: var(--primary);
        }
        .btn-shop {
            display: block;
            padding: 12px;
            background: var(--primary-bg);
            color: var(--primary);
            border: 1.5px solid var(--primary);
            border-radius: var(--radius-lg);
            font-size: 13px;
            font-weight: 600;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-shop:hover {
            background: var(--primary);
            color: var(--white);
        }

        /* =============================================
           DELIVERY ADDRESS
           ============================================= */
        .delivery-info p {
            font-size: 13px;
            color: var(--text-dark);
            margin-bottom: 5px;
            line-height: 1.6;
        }
        .delivery-info strong {
            color: var(--navy);
        }
    </style>
</head>
<body>

    <jsp:include page="/WEB-INF/partials/navbar.jsp"/>

    <div class="success-wrapper">

        <%-- SUCCESS BANNER --%>
        <div class="success-banner">
            <c:choose>
                <c:when test="${isSuccess}">
                    <div class="success-icon">🎉</div>
                    <div class="success-title">Order Placed Successfully!</div>
                    <div class="success-subtitle">
                        Thank you for shopping with FashionStore.
                        Your order is confirmed and being processed.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="success-icon">📋</div>
                    <div class="success-title">Order Details</div>
                    <div class="success-subtitle">
                        Here are the details for your order.
                    </div>
                </c:otherwise>
            </c:choose>
            <c:if test="${not empty order.trackingNumber}">
                <div class="success-tracking">
                    🔖 Tracking: ${order.trackingNumber}
                </div>
            </c:if>
        </div>

        <%-- MAIN LAYOUT --%>
        <div class="success-layout">

            <%-- LEFT — ORDER ITEMS + DELIVERY --%>
            <div class="success-left">

                <%-- ORDER ITEMS --%>
                <div class="success-card">
                    <div class="success-card-title">
                        🛍️ Items Ordered
                        (${enrichedItems.size()} item(s))
                    </div>
                    <c:forEach var="entry" items="${enrichedItems}">
                        <div class="success-item">
                            <img src="${pageContext.request.contextPath}/${entry.product.imageUrl}"
                                 alt="${entry.product.name}"
                                 class="success-item-img"
                                 onerror="this.src='${pageContext.request.contextPath}/assets/images/placeholder.jpg'"/>
                            <div class="success-item-info">
                                <div class="success-item-name">
                                    ${entry.product.name}
                                </div>
                                <div class="success-item-meta">
                                    Size: ${entry.variant.size} ×
                                    ${entry.orderItem.quantity}
                                </div>
                                <div class="success-item-meta">
                                    ₹<fmt:formatNumber
                                      value="${entry.orderItem.price}"
                                      pattern="#,##0.00"/> each
                                </div>
                            </div>
                            <div class="success-item-price">
                                ₹<fmt:formatNumber
                                  value="${entry.orderItem.price * entry.orderItem.quantity}"
                                  pattern="#,##0.00"/>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <%-- DELIVERY ADDRESS --%>
                <div class="success-card">
                    <div class="success-card-title">📍 Delivery Address</div>
                    <div class="delivery-info">
                        <p><strong>${order.deliveryName}</strong></p>
                        <p>📞 ${order.deliveryPhone}</p>
                        <p>${order.deliveryAddress}</p>
                        <p>${order.deliveryCity},
                           ${order.deliveryState} -
                           ${order.deliveryPincode}</p>
                    </div>
                </div>

            </div>

            <%-- RIGHT — ORDER SUMMARY + ACTIONS --%>
            <div class="success-right">

                <%-- ORDER SUMMARY --%>
                <div class="success-card">
                    <div class="success-card-title">📦 Order Summary</div>

                    <div class="success-info-row">
                        <span>Order ID</span>
                        <span><strong>#${order.orderId}</strong></span>
                    </div>
                    <div class="success-info-row">
                        <span>Order Date</span>
                        <span>${order.orderDate}</span>
                    </div>
                    <div class="success-info-row">
                        <span>Payment</span>
                        <span>${order.paymentMethod}</span>
                    </div>
                    <div class="success-info-row">
                        <span>Status</span>
                        <span>
                            <c:choose>
                                <c:when test="${order.orderStatus == 'Placed'}">
                                    <span style="color:#1D4ED8; font-weight:700;">
                                        📋 Placed
                                    </span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Processing'}">
                                    <span style="color:#92400E; font-weight:700;">
                                        ⚙️ Processing
                                    </span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Shipped'}">
                                    <span style="color:#4338CA; font-weight:700;">
                                        🚚 Shipped
                                    </span>
                                </c:when>
                                <c:when test="${order.orderStatus == 'Delivered'}">
                                    <span style="color:#065F46; font-weight:700;">
                                        ✅ Delivered
                                    </span>
                                </c:when>
                                <c:otherwise>
                                    ${order.orderStatus}
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:if test="${not empty order.estimatedDelivery}">
                        <div class="success-info-row">
                            <span>Est. Delivery</span>
                            <span>${order.estimatedDelivery}</span>
                        </div>
                    </c:if>
                    <div class="success-info-row total">
                        <span>Total Amount</span>
                        <span>
                            ₹<fmt:formatNumber
                              value="${order.totalAmount}"
                              pattern="#,##0.00"/>
                        </span>
                    </div>
                </div>

                <%-- ACTION BUTTONS --%>
                <div class="success-actions">
                    <a href="${pageContext.request.contextPath}/orders?action=track&orderId=${order.orderId}"
                       class="btn-track">
                        📍 Track Order
                    </a>
                    <a href="${pageContext.request.contextPath}/orders"
                       class="btn-orders">
                        📋 My Orders
                    </a>
                    <a href="${pageContext.request.contextPath}/products"
                       class="btn-shop">
                        🛍️ Continue Shopping
                    </a>
                </div>

            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/partials/footer.jsp"/>

</body>
</html>